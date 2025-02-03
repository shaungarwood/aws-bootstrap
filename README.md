# Bootstrap AWS

```
          .-~~~-.
  .- ~ ~-(       )_ _
 /                     ~ -.
|                           \
 \                         .'
   ~- . _____________ . -~
```

This will setup AWS to create:
 - a dev user
 - user group
 - IAM policy
 - access keys

> **Note:**
> Yes! I know you're not supposed to use access keys for root user.
> But this is easier than using the browser and poking around with your cursor like pleeb.

## Setup
1. [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
2. [Generate AWS credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) for the root user
3. Run `aws configure` and enter the root user access key and secret key
4. Run `terraform init` and `terraform apply` inside this directory
5. `aws configure import --csv file://aws_credentials.csv` to import the new user credentials into `~/.aws/credentials`. WARN: This will overwrite any existing credentials for the new user. You can modify the CSV file to change the profile name to something other than `default` if you want to keep existing defaul credentials.
6. `aws iam delete-access-key --access-key-id <root access-key-id>` to delete the access key for the root user (recommended)
