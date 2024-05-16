# Low Budget Project: Setting Up a Simple Web Application with Azure App Service and Azure SQL Database

**Objective:** Deploy a simple web application using Azure App Service and Azure SQL Database.

**Estimated Budget**
- **Azure App Service:** Free Tier
- **Azure SQL Database:** Basic Tier
- **Total Monthly Cost:** ~$5-10

**Steps**

1. **Create an Azure App Service**

- Navigate to the Azure Portal.
- Select "Create a resource" and choose "App Service."
- Fill in the necessary details (App name, Resource Group, etc.).
- Choose the Free Tier for the App Service plan.
- Click "Review + create" and then "Create."
  
2. **Deploy a Sample Web Application**

Use a sample application from GitHub (e.g., a simple Node.js or .NET Core app).
Deploy the application using Azure DevOps or directly from GitHub.
Ensure the deployment settings are configured to deploy to the newly created App Service.

3. **Create an Azure SQL Database**

Navigate to the Azure Portal.
Select "Create a resource" and choose "SQL Database."
Fill in the database details and choose the Basic Tier.
Create a new SQL Server or use an existing one.

4. **Connect the Web Application to the SQL Database**

Retrieve the connection string from the Azure SQL Database overview page.
Update the web application's configuration settings to include the SQL Database connection string.
Deploy the updated configuration to Azure App Service.

5. **Test the Web Application**

Access the web application via the App Service URL.
Ensure the application connects to the SQL Database and performs CRUD operations.
