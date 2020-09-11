# Wordpress-Deployment-on-EKS-and-RDS
#To create eks cluster
</br>
<b>eksctl create cluster -f cluster.yaml</b>
</br>
#check if cluster created
</br>
<b>eksctl get cluster -r ap-southeast-1</b>
</br>
#Command to update the default kubeconfig file to use our cluster as the current context.
</br>
<b>aws eks update-kubeconfig --name cluster1 -r ap-southeast-1</b>
</br>
#Create DB instance and deploy Wordpress over EKS Cluster using terraform
</br>
<b>terraform init
</br>
<b>terraform apply --auto-approve  </b>
</br>


</br>
#To destroy  infrastructure
</br>
<b>terraform destroy --auto-approve</b>
</br>

#To delete  EKS cluster

</br>
<b> eksctl delete cluster -f cluster.yaml</b>
</br>
