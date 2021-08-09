# FROM amazon/aws-lambda-nodejs:12
FROM public.ecr.aws/lambda/nodejs:14

ENV TEMP_DIR=/tmp/.lambdas/test

RUN mkdir -p $TEMP_DIR

WORKDIR ${TEMP_DIR}

COPY package.json ./

RUN npm install

# RUN mkdir deploy
COPY . .
RUN npm run build
# RUN npm prune --production # uncomment for production
# RUN zip -r $PROJECT_PATH/nest-lambda.zip . ../node_modules
RUN ls -ltr

RUN cp -r $TEMP_DIR/dist/. ${LAMBDA_TASK_ROOT}/
RUN cp -r $TEMP_DIR/node_modules ${LAMBDA_TASK_ROOT}/

RUN npm cache clean --force 

WORKDIR ${LAMBDA_TASK_ROOT}

CMD [ "index.handler" ]