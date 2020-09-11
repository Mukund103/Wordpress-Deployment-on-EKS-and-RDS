# Wordpress-Deployment-on-EKS-and-RDS
#To create eks cluster
<md>eksctl create cluster -f cluster.yaml

#check if cluster created
eksctl get cluster -r ap-southeast-1

#Command to update the default kubeconfig file to use our cluster as the current context.
aws eks update-kubeconfig --name cluster1 -r ap-southeast-1

#Create DB instance and deploy Wordpress over EKS Cluster using terraform
terraform init
terraform apply --auto-approve  



#To destroy  infrastructure
terraform destroy --auto-approve

#To delete  EKS cluster
eksctl delete cluster -f cluster.yaml
