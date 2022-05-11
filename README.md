# Akash Storj S3 Gateway

This is a very basic Docker image to simplify running a Storj S3 Gateway node on Akash.

## Run the S3 gateway

1. Setup a Storj account, and generate an 'Access Grant' from the 'Access' section of the Satellite dashboard. This is location specific, e.g. [eu1.storj.io/access-grants](https://eu1.storj.io/access-grants)
2. Using the example SDL below, replace the `ACCESS_GRANT` environment variable with the grant obtained in the previous step.
3. Deploy the SDL on Akash, check the logs and grab your S3 Access and Secret keys. You will also need the provider URL and randomly generated port shown in the deploy info.

```yml
---
version: "2.0"

services:
  node:
    image: ghcr.io/ovrclk/akash-storj-gateway
    env: 
      - ACCESS_GRANT=<grant-key>
    expose:
      - port: 7777
        to:
          - global: true

profiles:
  compute:
    node:
      resources:
        cpu:
          units: 1
        memory:
          size: 512Mi
        storage:
          size: 100Mi
  placement:
    dcloud:
      attributes:
        host: akash
      signedBy:
        anyOf:
          - akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63
      pricing:
        node:
          denom: uakt
          amount: 100

deployment:
  node:
    dcloud:
      profile: node
      count: 1
```

You can now visit the URL provided by Akash in a web browser, which will prompt you for the access key and secret to access the gateway UI.

## Configure AWS CLI

```bash
$ aws configure
---
AWS Access Key ID: [Enter your Gateway's Access Key]
AWS Secret Access Key: [Enter your Gateway's Secret Key]
Default region name: [null]
Default output format: [null]

$ aws configure set default.s3.multipart_threshold 64MB
```

Then use individual S3 actions such as `ls`. Note the endpoint is your provider URL and port from the Akash deployment.

```bash
aws s3 --endpoint=http://provider.akash.world:30620/ ls s3://bucket-name/
```

[See the Storj docs](https://docs.storj.io/dcs/api-reference/s3-gateway/#configure-aws-cli-to-use-gateway-st) for more information.