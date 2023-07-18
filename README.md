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
   sf org login web -d -a myhuborg
   ```

1. Clone this repository:

   ```
   git clone https://github.com/albarivas/plants
   cd plants
   ```

1. Create a scratch org and provide it with an alias (**plants** in the command below):

   ```
   sf org create scratch -d -f config/project-scratch-def.json -a plants
   ```

1. Push the app to your scratch org:

   ```
   sf project deploy start

   ```

1. Assign the **Plants_App** permission set to the default user:

   ```
   sf org assign permset -n Plants_App
   ```

1. Import sample data:

   ```
   sf data tree import -p data/data-plan.json
   ```

1. Open the scratch org:

   ```
   sf org open
   ```

1. Select custom theme: setup --> Themes and Branding --> Plants App --> Activate

1. Create a custom notification type: setup --> Custom Notifications --> New Custom Notification Type

- Name: Temperature Alert
- Developer Name: Temperature_Alert
- Make it available for Desktop and Mobile
