provider "aws" {
  region  = "ap-south-1"
}

module "sg" {
  source = "./SecurityGroup"
}


resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "wordpressdb"
  username             = "wordpress"
  password             = "wordpress"
  parameter_group_name = "default.mysql5.7"
  auto_minor_version_upgrade= false
  publicly_accessible= true
  vpc_security_group_ids= [module.sg.aws_security_group_id]
  skip_final_snapshot       = true
}

provider "kubernetes" {
  alias  = "kubernetes"
  config_context = "arn:aws:eks:ap-southeast-1:210563755787:cluster/cluster1"

}

module "wordpres" {
  source = "./wordpress"
  providers = {
    kubernetes.kubernetes = kubernetes.kubernetes

  }
  endpoint=aws_db_instance.default
  
}





