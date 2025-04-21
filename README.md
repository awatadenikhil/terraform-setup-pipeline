# terraform-setup-pipeline
    ./terraform init -backend-config="storage_account_name=terrav2o67627" -backend-config="container_name=terraform-state" -backend-config="key=workspace_terraform.tfstate" -backend-config="sas_token=?sv=2017-07-29&ss=b&srt=sco&sp=rwdlac&se=2024-07-25T12:14:09Z&st=2022-07-26T12:14:09Z&spr=https&sig=%2Bt6%2FtE13%2FsdTfPgmDN7vj0OjbE%2FOGK784ySwcj072uE%3D"

-->
./terraform workspace new devlopment

-->
./terraform plan

-->
./terraform apply


====>./terraform init
====>./terraform plan
====>./terraform apply

# Code
git remote add origin https://nikhilawatadeaz@dev.azure.com/nikhilawatadeaz/Terraform_Practice_1/_git/Terraform_Practice_1
git push -u origin --all

Service Connection : Teraform_Practice_1_Service_Connection

App Name : Terraform_Practice_1_App
Subscription ID : 580b65d7-d259-4b44-9c3c-52eecdbbeb12
Subscription name: Azure subscription 1
Client ID/Service Principal Id : a0fd440b-7aa1-42d6-a5d7-58374f2276f9
Value/Service principle key : BCY8Q~S444SXJchckN-UJa.3DZRyD~REBekq5bx_
Secret Id : e797e7f1-2677-437c-a9da-744474f4eb39
Tanent ID : 5cb5468e-73ed-461d-a20e-cb44477e0f5



Steps
1) Creat App in Azure Portal and generate secret which are mentioned in above section
2) Go to Azure Subscription(Azure subscription 1) -> Access control  -> Add -> Add Role assignment -> contractor -> select Appplication
3) Go to dev ops -> Select Project setting -> Service Connection -> select created App 


az logout
az login --service-principal -u a0fddd0b-7aa1-42d6-a5d7-58374f2276f9 -p BCYdddSetHSXJchckN-UJa.3DZRyD~REBekq5bx_ --tenant 5cb5ddd8e-73ed-461d-a20e-cb4e3c77e0f5
az login --service-principal -u a0fddd0b-7aa1-42d6-a5d7-58374f2276f9 -p BCY8Q~SetdddchckN-UJa.3DZRyD~REBekq5bx_ --tenant 5ddd468e-73ed-461d-a20e-cb4e3c77e0f5

# setup code 

./Terraform init
./terraform plan
./terraform apply



# Note
  if you are deleting resouce group then make sure to delete first key vault policy beore resource group.
