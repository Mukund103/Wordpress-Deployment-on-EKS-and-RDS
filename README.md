# Wordpress-Deployment-on-EKS-and-RDS
#To create eks cluster
</br>
<b>eksctl create cluster -f cluster.yaml</b>
</br>
#check if cluster created
</br>
eksctl get cluster -r ap-southeast-1
</br>
#Command to update the default kubeconfig file to use our cluster as the current context.
</br>
aws eks update-kubeconfig --name cluster1 -r ap-southeast-1
</br>
#Create DB instance and deploy Wordpress over EKS Cluster using terraform
</br>
terraform init
</br>
terraform apply --auto-approve  
</br>


</br>
#To destroy  infrastructure
</br>
terraform destroy --auto-approve
</br>

#To delete  EKS cluster
</br>
eksctl delete cluster -f cluster.yaml
</br>
