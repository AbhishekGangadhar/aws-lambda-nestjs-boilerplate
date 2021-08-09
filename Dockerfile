# FROM amazon/aws-lambda-nodejs:12
FROM public.ecr.aws/lambda/nodejs:14

ARG PROJECT_PATH=`pwd`
ARG PROJECT_NAME=`basename "$PROJECT_PATH"`
ARG TEMP_DIR=~/.lambdas/$PROJECT_NAME/

CMD mkdir -p $TEMP_DIR

COPY . $TEMP_DIR/.

CMD cd $TEMP_DIR
CMD mkdir deploy
CMD npm install
CMD npm run build
CMD npm prune --production
# CMD zip -r $PROJECT_PATH/nest-lambda.zip . ../node_modules

RUN npm cache clean --force

COPY ./dist/. ${LAMBDA_TASK_ROOT}/.
COPY ../node_modules ${LAMBDA_TASK_ROOT}/.

CMD [ "ls" "-ltr"]

CMD [ "cd" "${LAMBDA_TASK_ROOT}"]

CMD [ "ls" "-ltr"]

CMD [ "index.handler" ]
