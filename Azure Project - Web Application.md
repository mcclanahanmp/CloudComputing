# Low Budget Project: Setting Up a Simple Web Application with Azure App Service and Azure SQL Database

**Objective:** Deploy a simple web application using Azure App Service and Azure SQL Database.

**Estimated Budget:**
- **Azure App Service:** Free Tier
- **Azure SQL Database:** Basic Tier
- **Total Monthly Cost:** ~$5-10

**Azure GUI Steps:**

1. **Create an Azure App Service**
   - Navigate to the Azure Portal.
   - Select "Create a resource" and choose "App Service."
   - Fill in the necessary details (App name, Resource Group, etc.).
   - Choose the Free Tier for the App Service plan.
   - Click "Review + create" and then "Create."
  
2. **Deploy a Sample Web Application**
   - Use a sample application from GitHub (e.g., a simple Node.js or .NET Core app).
   - Deploy the application using Azure DevOps or directly from GitHub.
   - Ensure the deployment settings are configured to deploy to the newly created App Service.

3. **Create an Azure SQL Database**
   - Navigate to the Azure Portal.
   - Select "Create a resource" and choose "SQL Database."
   - Fill in the database details and choose the Basic Tier.
   - Create a new SQL Server or use an existing one.

4. **Connect the Web Application to the SQL Database**
   - Retrieve the connection string from the Azure SQL Database overview page.
   - Update the web application's configuration settings to include the SQL Database connection string.
   - Deploy the updated configuration to Azure App Service.

5. **Test the Web Application**
   - Access the web application via the App Service URL.
   - Ensure the application connects to the SQL Database and performs CRUD operations.

**Azure CLI Steps:**

**Important: Ensure you have the appropriate Azure CLI installed and authenticated before running these commands. In the steps provided, 
asterisks (e.g., *ResourceGroupName*, *AppServiceName*, *SQLServerName*) are used to indicate placeholders where if you choose to, you can 
replace the text inside the asterisks with your specific names and details. Then, remove the asterisks before execution.**

1. **Login to Azure**
   - az login

2. **Create a Resource Group**
   - az group create --name *MyResourceGroup* --location *eastus*
   
3. **Create an Azure App Service Plan**
   - az appservice plan create --name *MyAppServicePlan* --resource-group *MyResourceGroup* --sku *FREE*

4. **Create a Web App**
   - az webapp create --name *MyWebApp* --resource-group *MyResourceGroup* --plan *MyAppServicePlan*
  
5. **Deploy a Sample Web Application (e.g., from GitHub)**
   - az webapp deployment source config --name *MyWebApp* --resource-group *MyResourceGroup* --repo-url https://github.com/Azure-Samples/html-docs-hello-world --branch master --manual-integration

6. **Create an Azure SQL Database**
   - az sql server create --name *MySqlServer* --resource-group *MyResourceGroup* --location *eastus* --admin-user *myadmin* --admin-password *YourP@ssword123*
   - az sql db create --resource-group *MyResourceGroup* --server *MySqlServer* --name *MyDatabase* --service-objective *Basic*

7. **Configure the Web App to Use the SQL Database**
    - CONNECTION_STRING=$(az sql db show-connection-string --server *MySqlServer* --name *MyDatabase* --client ado.net)
    - az webapp config connection-string set --name *MyWebApp* --resource-group *MyResourceGroup* --settings DefaultConnection=$CONNECTION_STRING --connection-string-type SQLAzure

8. **Test the Web Application**
    - Access the web application via the App Service URL.



