# Medium Budget Project: Deploying a Scalable E-Commerce Website with Azure App Service, Azure SQL Database, and Azure Blob Storage

**Objective:** Deploy a scalable e-commerce website with image storage and database integration.

**Estimated Budget**
Azure App Service: Standard Tier
Azure SQL Database: Standard Tier
Azure Blob Storage: Hot Access Tier
Total Monthly Cost: ~$50-100

**Azure GUI Steps**

1. **Create an Azure App Service**
   - Navigate to the Azure Portal.
   - Select "Create a resource" and choose "App Service."
   - Fill in the necessary details (App name, Resource Group, etc.).
   - Choose the Standard Tier for the App Service plan.
   - Click "Review + create" and then "Create."

2. **Deploy the E-Commerce Application**
   - Use a sample e-commerce application from GitHub or develop your own.
   - Deploy the application using Azure DevOps, configuring CI/CD pipelines for automated deployments.

3. **Create an Azure SQL Database**
   - Select "Create a resource" and choose "SQL Database."
   - Fill in the database details and choose the Standard Tier for the SQL Database.
   - Create a new SQL Server or use an existing one.

4. **Create an Azure Blob Storage Account**
   - Select "Create a resource" and choose "Storage account."
   - Fill in the necessary details and select the Hot Access Tier.
   - Create a container within the storage account to store product images.

5. **Connect the Web Application to Azure Services**
   - Update the web application's configuration to include connection strings for both the SQL Database and Blob Storage.
   - Implement functionality in the application to upload, retrieve, and display images from Blob Storage.

6. **Test and Scale the Application**
   - Access the web application via the App Service URL.
   - Ensure all features (e.g., product listings, image uploads) work correctly.
   - Configure autoscaling settings for the App Service to handle varying loads.

**Azure CLI Steps**

**Important: Ensure you have the appropriate Azure CLI installed and authenticated before running these commands. In the steps provided, 
angle brackets (e.g., <ResourceGroupName>, <AppServiceName>, <SQLServerName>) are used to indicate placeholders where you should replace 
the text inside the brackets with your specific names and details.**

1. **Login to Azure**
   - az login

2. **Create a Resource Group**
   - az group create --name EcommerceResourceGroup --location eastus
   
3. **Create an Azure App Service Plan**
   - az appservice plan create --name <EcommerceAppServicePlan> --resource-group <EcommerceResourceGroup> --sku <S1>

4. **Create a Web App**
   - az webapp create --name <EcommerceWebApp> --resource-group <EcommerceResourceGroup> --plan <EcommerceAppServicePlan>
  
5. **Deploy the E-Commerce Application (e.g., from GitHub)**
   - az webapp deployment source config --name <EcommerceWebApp> --resource-group <EcommerceResourceGroup> --repo-url https://github.com/Azure-Samples/aspnet-core-app --branch master --manual-integration

6. **Create an Azure SQL Database**
   - az sql server create --name <EcommerceSqlServer> --resource-group <EcommerceResourceGroup> --location <eastus> --admin-user <myadmin> --admin-password <MyP@ssword123>
   - az sql db create --resource-group <EcommerceResourceGroup> --server <EcommerceSqlServer> --name <EcommerceDatabase> --service-objective S0

7. **Create an Azure Blob Storage Account**
   - az storage account create --name <ecommercestorageaccount> --resource-group <EcommerceResourceGroup> --location <eastus> --sku <Standard_LRS>
  
8. **Create a Blob Container**
   - az storage container create --account-name <ecommercestorageaccount> --name <product-images>

9. **Configure the Web App to Use the SQL Database and Blob Storage**
    - SQL_CONNECTION_STRING=$(az sql db show-connection-string --server <EcommerceSqlServer> --name <EcommerceDatabase> --client ado.net)
    - STORAGE_CONNECTION_STRING=$(az storage account show-connection-string --name <ecommercestorageaccount> --resource-group <EcommerceResourceGroup>)
    - az webapp config connection-string set --name <EcommerceWebApp> --resource-group <EcommerceResourceGroup> --settings DefaultConnection=$SQL_CONNECTION_STRING --connection-string-type SQLAzure
    - az webapp config appsettings set --name <EcommerceWebApp> --resource-group <EcommerceResourceGroup> --settings AZURE_STORAGE_CONNECTION_STRING=$STORAGE_CONNECTION_STRING

10. **Test and Scale the Application**
    - Access the web application via the App Service URL.
    - Configure autoscaling if needed.

 
