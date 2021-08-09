# AWS Lambda NestJs Boilerplate

Boilerplate code for using NestJs with AWS Lambda

## Installation

```bash
$ npm install
```

## Running the app

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```

## Test

```bash
# unit tests
$ npm run test

# e2e tests
$ npm run test:e2e

# test coverage
$ npm run test:cov
```

## Create Lambda Zip

```bash
$ bash create_lambda_zip.sh
```

This command will create a zip file called "nest-lambda.zip"


## License

  Nest is [MIT licensed](LICENSE).


## Deploy to Lambda via Container
Run the following commands from the project directory that contains Dockerfile:

```
docker build -t lambda-docker .
docker run -p 9000:8080 lambda-docker
```
(Optional) Test your application locally using the runtime interface emulator. From a new terminal window, post an event to the following endpoint using a curl command:
```
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```

This command invokes the function running in the container image and returns a response.
Authenticate the Docker CLI to your Amazon ECR registry.
```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com
```

Create a repository in Amazon ECR using the create-repository command.
```
aws ecr create-repository --repository-name hello-world --image-scanning-configuration scanOnPush=true --image-tag-mutability MUTABLE
```

Tag your image to match your repository name, and deploy the image to Amazon ECR using the docker push command.
```
docker tag  hello-world:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/hello-world:latest
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/hello-world:latest
```
