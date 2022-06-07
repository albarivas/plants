# Sample App to Manage your garden's plants!

[![CI Workflow](https://github.com/albarivas/plants/workflows/CI/badge.svg)](https://github.com/albarivas/plants/actions?query=workflow%3ACI)[![codecov](https://codecov.io/gh/albarivas/plants/branch/master/graph/badge.svg)](https://codecov.io/gh/albarivas/plants)

## Installing using a Scratch Org

1. Set up your environment. Follow the steps in the [Quick Start: Lightning Web Components](https://trailhead.salesforce.com/content/learn/projects/quick-start-lightning-web-components/) Trailhead project. The steps include:

   - Enable Dev Hub in your Trailhead Playground
   - Install Salesforce CLI
   - Install Visual Studio Code
   - Install the Visual Studio Code Salesforce extensions, including the Lightning Web Components extension

1. If you haven't already done so, authorize your hub org and provide it with an alias (**myhuborg** in the command below):

   ```
   sfdx force:auth:web:login -d -a myhuborg
   ```

1. Clone this repository:

   ```
   git clone https://github.com/albarivas/plants
   cd plants
   ```

1. Create a scratch org and provide it with an alias (**plants** in the command below):

   ```
   sfdx force:org:create -s -f config/project-scratch-def.json -a plants
   ```

1. Push the app to your scratch org:

   ```
   sfdx force:source:push
   ```

1. Assign the **Plants_App** permission set to the default user:

   ```
   sfdx force:user:permset:assign -n Plants_App
   ```

1. Import sample data:

   ```
   sfdx force:data:tree:import -p ./data/data-plan.json
   ```

1. Open the scratch org:

   ```
   sfdx force:org:open
   ```
