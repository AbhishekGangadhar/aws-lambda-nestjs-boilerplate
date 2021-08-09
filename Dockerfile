# FROM amazon/aws-lambda-nodejs:12
FROM public.ecr.aws/lambda/nodejs:14

COPY dist/. ${LAMBDA_TASK_ROOT}/

COPY  package*.json ${LAMBDA_TASK_ROOT}/

RUN mkdir -p ${LAMBDA_TASK_ROOT}/node_modules

RUN npm ci --only=development

RUN npm cache clean --force

CMD [ "index.handler" ]
