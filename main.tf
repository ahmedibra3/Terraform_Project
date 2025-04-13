# Create S3 Bucket and DaynmoDB for remote statefile
module "Project_backend" {
  source  = "./Modules/Backend"
}

module "Main_VPC-IGW" {
  source   = "./Modules/VPC"
  Vpc-cidr = "10.0.0.0/16"
  IGW-name = "project-IGW"
}
module "Public-RT" {
  source  = "./Modules/RouteTable"
  VPC-ID  = module.Main_VPC-IGW.VPC-ID
  IGW-ID  = module.Main_VPC-IGW.IGW-ID
  RT_Name = "Public-RT"
}


module "Subnet-1" {
  source            = "./Modules/Subnets"
  VPC_ID            = module.Main_VPC-IGW.VPC-ID
  CIDR_Subnet       = "10.0.0.0/24"
  Subnet_Name       = "public-1"
  Public_or_Private = true #true for a Public Subnet
  RT-ID             = module.Public-RT.RT-ID
}
module "NAT-1" {
  source    = "./Modules/NAT"
  EIP       = "EIP1"
  SubNet-ID = module.Subnet-1.Subnet-ID
  NAT-Name  = "NAT-1"
}
module "Private-RT-1" {
  source  = "./Modules/RouteTable"
  VPC-ID  = module.Main_VPC-IGW.VPC-ID
  NAT-ID  = module.NAT-1.NAT-ID
  RT_Name = "Private-RT-1"
}

module "Subnet-2" {
  source            = "./Modules/Subnets"
  VPC_ID            = module.Main_VPC-IGW.VPC-ID
  CIDR_Subnet       = "10.0.1.0/24"
  Subnet_Name       = "private-1"
  RT-ID             = module.Private-RT-1.RT-ID
}
module "Subnet-3" {
  source            = "./Modules/Subnets"
  VPC_ID            = module.Main_VPC-IGW.VPC-ID
  CIDR_Subnet       = "10.0.2.0/24"
  Subnet_Name       = "public-2"
  Public_or_Private = true
  RT-ID             = module.Public-RT.RT-ID
}
module "NAT-2" {
  source    = "./Modules/NAT"
  EIP       = "EIP2"
  SubNet-ID = module.Subnet-3.Subnet-ID
  NAT-Name  = "NAT-2"
}
module "Private-RT-2" {
  source  = "./Modules/RouteTable"
  VPC-ID  = module.Main_VPC-IGW.VPC-ID
  NAT-ID  = module.NAT-2.NAT-ID
  RT_Name = "Private-RT-2"
}
module "Subnet-4" {
  source            = "./Modules/Subnets"
  VPC_ID            = module.Main_VPC-IGW.VPC-ID
  CIDR_Subnet       = "10.0.3.0/24"
  Subnet_Name       = "private-2"
  RT-ID             = module.Private-RT-2.RT-ID
}
module "Sec-Group" {
  source  = "./Modules/securityGroup"
  VPC-ID  = module.Main_VPC-IGW.VPC-ID
  SG-Name = "HTTP-SSH"
}

module "Nginx" {
  source            = "./Modules/EC2s"
  instance-type     = "t2.micro"
  Subnet-ID         = module.Subnet-1.Subnet-ID
  Security-Group-ID = module.Sec-Group.Sec-Group-ID
  Target-Group-arn = module.LoadBalancer-External.Target-Group-ARN
  instance-name     = "Nginx-Proxy"
  Enable-Remote     = true
  Remote-Exec = [<<-EOF
  sudo yum install -y nginx
  sudo systemctl enable --now nginx
  sudo bash -c 'cat <<CONF > /etc/nginx/conf.d/reverse-proxy.conf
server {
  listen 80;
  location / {
      proxy_pass http://${module.LoadBalancer-Internal.LoadBalancer-DNS};
  }
}
CONF'
  sudo systemctl restart nginx
EOF
  ]

}
module "Nginx2" {
  source            = "./Modules/EC2s"
  instance-type     = "t2.micro"
  Subnet-ID         = module.Subnet-3.Subnet-ID
  Security-Group-ID = module.Sec-Group.Sec-Group-ID
  instance-name     = "Nginx2-Proxy"
  Target-Group-arn = module.LoadBalancer-External.Target-Group-ARN
  Enable-Remote     = true
  Remote-Exec = [<<-EOF
  sudo yum install -y nginx
  sudo systemctl enable --now nginx
  sudo bash -c 'cat <<CONF > /etc/nginx/conf.d/reverse-proxy.conf
server {
  listen 80;
  location / {
      proxy_pass http://${module.LoadBalancer-Internal.LoadBalancer-DNS};
  }
}
CONF'
  sudo systemctl restart nginx
EOF
  ]

}
module "BE1-Apache" {
  source            = "./Modules/EC2s"
  instance-type     = "t2.micro"
  Subnet-ID         = module.Subnet-2.Subnet-ID
  Security-Group-ID = module.Sec-Group.Sec-Group-ID
  instance-name     = "BE-Apache"
  Target-Group-arn = module.LoadBalancer-Internal.Target-Group-ARN
  user-data         = <<-EOF
     #!/bin/bash
     yum update -y
     yum install -y httpd
     systemctl enable --now httpd
     echo "<h1><center> Welcome To In Server 1 </center></h1>" > /var/www/html/index.html
     systemctl restart httpd
   EOF
}
module "BE2-Apache" {
  source            = "./Modules/EC2s"
  instance-type     = "t2.micro"
  Subnet-ID         = module.Subnet-4.Subnet-ID
  Security-Group-ID = module.Sec-Group.Sec-Group-ID
  instance-name     = "BE-Apache2"
  Target-Group-arn = module.LoadBalancer-Internal.Target-Group-ARN
  user-data         = <<-EOF
     #!/bin/bash
     yum update -y
     yum install -y httpd
     systemctl enable --now httpd
     echo "<h1><center> Welcome To In Server 2 </center></h1>" > /var/www/html/index.html
     systemctl restart httpd
   EOF
}
module "LoadBalancer-External" {
  source            = "./Modules/LBs"
  Target-Group-Name = "External-Target-Group"
  VPC-ID            = module.Main_VPC-IGW.VPC-ID
  LB-Name           = "External-LB"
  LB-Sec-Group      = [module.Sec-Group.Sec-Group-ID]
  SubNet-ID         = [module.Subnet-1.Subnet-ID, module.Subnet-2.Subnet-ID]
  Internal-LB       = false
}
module "LoadBalancer-Internal" {
  source            = "./Modules/LBs"
  Target-Group-Name = "Internal-Target-Group"
  VPC-ID            = module.Main_VPC-IGW.VPC-ID
  LB-Name           = "Internal-LB"
  LB-Sec-Group      = [module.Sec-Group.Sec-Group-ID]
  SubNet-ID         = [module.Subnet-3.Subnet-ID, module.Subnet-4.Subnet-ID]
  Internal-LB       = true
}

module "Logs" {
  source     = "./Modules/Logging"
  Local-Exec = <<EOT
    cat <<END > ./all-IPs.txt 
    "${module.Subnet-1.Name} ${module.Nginx.EC2-IP}"
    "${module.Subnet-3.Name} ${module.Nginx2.EC2-IP}"
  EOT 
}
