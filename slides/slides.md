# Continuous Delivery in Government

**_DevOps fundamentals for the public sector_**

Aidan Feldman, Civic Technologist

## Setup

1. Go to Visual Studio Online: [online.visualstudio.com](https://online.visualstudio.com/environments)
1. Sign in, or create a Microsoft+Azure account if needed

---

class: center, middle

## Intros

---

class: center, middle

## Exercise

---

class: center, middle

### What's your agency's Dev[Sec]Ops maturity?

---

class: center, middle

### What's _your_ level of Dev[Sec]Ops experience?

---

## What we're going to accomplish\*

- Setting up a development environment in [Visual Studio Online](https://visualstudio.microsoft.com/services/visual-studio-online/)
- Running an application "locally"
- Automated application testing
- Deploying to infrastructure-as-a-service (IaaS)
- Deploying to a platform-as-a-service (PaaS)
- Automated security testing
- Continuous integration (CI)

_\*If we're lucky_

---

## Disclaimers

- _Please_ ask questions
  - If you have one, someone else is probably thinking the same thing
- We are using Azure, but this is not an endorsement
  - Could use any number of cloud providers
- You will need a credit/debit card
  - Just for verification; shouldn't cost anything

---

class: center, middle

## [delivery.afeld.me](https://delivery.afeld.me/)

---

## Setup

1. Go to [Visual Studio Online](https://online.visualstudio.com/environments)
1. Sign in, or create a Microsoft+Azure account if needed
1. Create a Billing Plan
1. Create an Environment, using a `Git repository` of `afeld/delivery`
1. Click the Environment to Connect
1. [Open a terminal](https://code.visualstudio.com/docs/editor/integrated-terminal)

---

## Visual Studio Online

To run the app from Visual Studio Online:

1. Go into the application directory

   ```sh
   cd app
   ```

1. Install dependencies.

   ```sh
   pip3 install -r requirements.txt --user
   ```

---

### Run the app

1. Start the app server.

   ```sh
   flask run
   ```

1. It should say `Running on http://127.0.0.1:5000/`
1. In the Activity Bar (on the left), click the Remote Explorer
1. Under `Environment Details`, then `Forwarded Ports`, click `Port :5000`

This should open a new browser tab that says "Hello, World!"

---

class: center, middle

## Speed check

---

## Automated testing

Run the tests:

```sh
pytest test_local.py
```

---

### Test-driven development (TDD) assignment

1. Add a test for a new route: `/bye` should return `Goodbye!`
1. Run the tests again

   ```sh
   pytest test_local.py
   ```

1. Get the test to pass

---

## Infrastructure-as-a-service (IaaS)

1. Go to [Create a Virtual Machine](https://portal.azure.com/#create/Microsoft.VirtualMachine) (VM)
1. Fill in the Basics
   - **Resource group:** `Create new`, then enter `vm-manual`
   - **Virtual machine name:** `workshop`
   - **Username:** `vsonline`
   - **SSH public key:**
     1. From terminal, run `cat ~/.ssh/id_rsa.pub`
     1. Copy the output (`ssh-rsa` through `vsonline`)
     1. Paste into input field
   - **Select inbound ports:** Select `HTTP` and `SSH`
   - Leave the rest as defaults
1. Click `Review + create`
1. Click `Create`

---

### SSH

1. Click `Go to resource`
1. Copy the `Public IP address`
   - Don't close the tab
1. From the terminal, run `ssh <IP>`

The prompt should change to `vsonline@workshop:~$`.

---

### Deploy

1. Install dependencies

   ```sh
   sudo apt-get update && sudo apt-get install -y python3-flask
   ```

1. Get the app code

   ```sh
   git clone --depth=1 https://github.com/afeld/delivery.git
   ```

1. Go into the app directory

   ```sh
   cd delivery/app
   ```

---

### Deploy (continued)

1. Start the app server

   ```sh
   sudo FLASK_APP=app.py flask run -h 0.0.0.0 -p 80
   ```

1. Go back to your Azure Portal tab
1. Copy the `Public IP address`
1. Open a new browser tab
1. Paste the IP into the URL bar
1. Press return

---

### What did we do?

1. Created a virtual machine
1. Provided an SSH key
1. SSH'd in
1. Installed dependencies
1. Downloaded the app code
1. Started the server

---

### What _didn't_ we do?

- Configure HTTPS
- Ensure high availability
- Ensure that operating system packages stay up-to-date
- Harden the SSH configuration
- Set up logging
- ...

---

### Exit

1. Press CONTROL+c
1. Type `exit` and press return

Your prompt should change back to `vsonline:~/workspace`.

---

class: center, middle

### How long would it take you to recreate?

---

class: center, middle

### Why might that be a problem?

---

### Why might that be a problem?

- Creating new environments (staging)
- Migration
- Accidental deletion
- Security incidents

---

class: center, middle

## Break?

---

## Infrastructure as code

Setting up the Azure-level stuff.

1. Log into the Azure CLI

   ```sh
   az login
   ```

---

### Infrastructure as code, continued

1. Go into the [`terraform/`](https://github.com/afeld/delivery/tree/master/terraform) directory

   ```sh
   cd terraform
   ```

1. Initialize Terraform

   ```sh
   terraform init
   ```

1. Create the infrastructure

   ```sh
   terraform apply
   ```

---

### Configuration as code

- Setting up the virtual machine-level stuff
- We'll use Ansible, but Chef, Puppet, etc. are equivalent configuration management tools

---

### Configuration as code

1. Go to the [`ansible/`](https://github.com/afeld/delivery/tree/master/ansible) directory

   ```sh
   cd ../ansible
   ```

1. Configure the virtual machine via Ansible playbook

   ```sh
   ansible-playbook -i vms.azure_rm.yml init.yml
   ```

---

### Idempotency

1. Run Terraform again:

   ```sh
   cd ../terraform
   terraform apply
   ```

1. What happened?
1. Visit the `public_ip` in your browser
1. Run Ansible again

   ```sh
   cd ../ansible
   ansible-playbook -i vms.azure_rm.yml init.yml
   ```

1. What happened?

---

class: center, middle

### Why is infrastructure/configuration as code a good idea?

---

### Why is infrastructure/configuration as code a good idea?

- Consistency/repeatability
- Auditability
- Automate-ability
- Unlike documentation, keeps itself up-to-date

---

class: center, middle

## Break?

---

## Azure App Services

_Roughly following the [Python Quickstart](https://docs.microsoft.com/en-us/azure/app-service/containers/quickstart-python)._

---

### Deploy

1. Deploy the application

   ```sh
   cd ../app
   az webapp up \
     --sku F1 \
     --name <yourname>-test
   ```

1. It should output a URL. Copy to a new browser tab, and you should see "Hello, World!"
1. Try going to the `https://` version of that same URL

---

### View logs

1. Tail the logs

   ```sh
   az webapp log tail
   ```

1. In your tab with the web page open, hit refresh
1. Look at the log output in your terminal

---

### What did we do?

1. Ran a single command
1. _Fin._

---

### What _didn't_ we do?

- Configure HTTPS
- Ensure high availability
- Ensure that operating system packages stay up-to-date
- Harden the SSH configuration
- Set up logging
- ...

...because _all are done for us_.

---

## Security tests

1. Open [`test_security.py`](https://github.com/afeld/delivery/blob/master/app/test_security.py)
1. Modify the `HOST` to be your deployed app
1. Run the tests

   ```sh
   pytest test_security.py
   ```

---

### Making security tests pass

1. Force HTTPS

   ```sh
   az webapp update --https-only true
   ```

1. Run the tests again

   ```sh
   pytest test_security.py
   ```

---

### Continuous integration (CI)

1. [Sign up](https://github.com/join) / [sign in](https://github.com/login) to github.com
   - Free plan is fine
1. From [the workshop repository](https://github.com/afeld/delivery), click `Use this template`
1. For `Repository name`, put in `delivery` (anything, really)
1. Click `Create repository from template`
1. On your newly created repository, click the `Actions` tab
1. You should see the build running

---

### Continuous integration (CI) assignment

Get [Bandit](https://pypi.org/project/bandit/) to run against your repository. Do so by editing `.github/workflows/smoke_tests.yml` through GitHub.

_A clue: see how [`run`](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/workflow-syntax-for-github-actions#jobsjob_idstepsrun) is being used._

---

class: center, middle

### Why is continuous integration a good idea?

---

### Why is continuous integration a good idea?

- Consistency/repeatability
- Auditability
- Automate-ability
- Unlike documentation, keeps itself up-to-date

---

## Cleanup\*

To ensure you don't get charged for anything:

1. View [all resources](https://portal.azure.com/#blade/HubsExtension/BrowseAll)
1. Select all
1. `Delete`

_\*You can keep them if you like, but that's on you._

---

## What we did

- Set up a development environment
- Ran an application "locally"
- Automated application testing
- Deployed to infrastructure-as-a-service (IaaS)
- Deployed to a platform-as-a-service (PaaS)
- Automated security testing

---

## General principles

- Do less
- Leverage platforms
- Automate
- Get skills in-house

---

## Questions?

[@aidanfeldman](https://twitter.com/aidanfeldman)

---

## Thanks!

[@aidanfeldman](https://twitter.com/aidanfeldman)
