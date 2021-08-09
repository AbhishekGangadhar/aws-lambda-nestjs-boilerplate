# FROM amazon/aws-lambda-nodejs:12
FROM public.ecr.aws/lambda/nodejs:14

ARG PROJECT_NAME=test
ARG TEMP_DIR=~/.lambdas/$PROJECT_NAME

RUN mkdir -p $TEMP_DIR



COPY package.json $TEMP_DIR/

RUN cd $TEMP_DIR
RUN npm install

# RUN mkdir deploy
COPY . $TEMP_DIR/
RUN cd $TEMP_DIR
RUN npm run build
RUN npm prune --production
# RUN zip -r $PROJECT_PATH/nest-lambda.zip . ../node_modules

RUN npm cache clean --force 

RUN cp -r ./dist/* ${LAMBDA_TASK_ROOT}/
RUN cp -r ./node_modules ${LAMBDA_TASK_ROOT}/

RUN [ "ls" "-ltr"]

RUN [ "cd" "${LAMBDA_TASK_ROOT}"]

RUN [ "ls" "-ltr"]

RUN cd ${LAMBDA_TASK_ROOT}

CMD [ "index.handler" ]
