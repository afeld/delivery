# Continuous Delivery workshop

Workshop demonstrating the power of platforms, via Microsoft Azure.

## Setup

1. Go to [Visual Studio Online](https://online.visualstudio.com/environments)
1. Sign in, or create a Microsoft+Azure account if needed
1. Create a Billing Plan
1. Create an Environment, using a `Git repository` of `afeld/delivery`
1. Click the Environment to Connect
1. [Open a terminal](https://code.visualstudio.com/docs/editor/integrated-terminal)

## Visual Studio Online

To run the app from Visual Studio Online:

1. Install dependencies.

   ```sh
   pip3 install -r requirements.txt --user
   ```

1. Start the app server.

   ```sh
   flask run
   ```

1. It should say `Running on http://127.0.0.1:5000/`
1. Click the Remote Explorer in the Activity Bar
1. Under `Environment Details`, then `Forwarded Ports`, click `Port :5000`

This should open a new browser tab that says "Hello World!"

## Azure App Services

1. Downgrade the Azure CLI (temporary workaround for [unreleased bug fix](https://github.com/Azure/azure-cli/issues/11221))

   ```sh
   sudo apt-get update
   sudo apt-get install --assume-yes --allow-downgrades azure-cli=2.0.75-1~stretch
   ```

1. Log in to the Azure CLI

   ```sh
   az login
   ```

### Deploy

1. Deploy the application—you can use another location, like `"Australia Central"`

   ```sh
   az webapp up --sku F1 --name australia-test --location "Central US"
   ```

1. It should output a URL. Copy to a new browser tab, and you should see "Hello World!"
1. Try going to the `https://` version of that same URL

### View logs

1. Tail the logs

   ```sh
   az webapp log tail
   ```

1. In your tab with the web page open, hit refresh
1. Look at the log output in your terminal

## Cleanup

To ensure you don't get charged for anything:

1. View [all resources](https://portal.azure.com/#blade/HubsExtension/BrowseAll)
1. Select all
1. `Delete`
