# Continuous Delivery workshop

1. Go to [Visual Studio Online](https://online.visualstudio.com/environments)
1. Sign in, or create a Microsoft+Azure account if needed
1. Create a Billing Plan
1. Create an Environment, using a `Git repository` of `afeld/delivery`
1. Click the Environment to Connect
1. [Open a terminal](https://code.visualstudio.com/docs/editor/integrated-terminal)

## Visual Studio Online

To run the app from Visual Studio Online:

1. From the terminal, run the following:

   ```sh
   pip3 install -r requirements.txt --user
   flask run
   ```

1. It should say `Running on http://127.0.0.1:5000/`
1. Click the Remote Explorer in the Activity Bar
1. Under `Environment Details`, then `Forwarded Ports`, click `Port :5000`

This should open a new browser tab that says "Hello World!"
