# FROM amazon/aws-lambda-nodejs:12
FROM public.ecr.aws/lambda/nodejs:14

ENV TEMP_DIR=~/.lambdas/test

RUN mkdir -p $TEMP_DIR

WORKDIR ${TEMP_DIR}

COPY package.json ./

RUN npm install

# RUN mkdir deploy
COPY . $TEMP_DIR/
RUN npm run build
RUN npm prune --production
# RUN zip -r $PROJECT_PATH/nest-lambda.zip . ../node_modules

RUN npm cache clean --force 

RUN cp -r ./dist/* ${LAMBDA_TASK_ROOT}/
RUN cp -r ./node_modules ${LAMBDA_TASK_ROOT}/

WORKDIR ${LAMBDA_TASK_ROOT}

CMD [ "index.handler" ]
