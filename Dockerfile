# FROM amazon/aws-lambda-nodejs:12
FROM public.ecr.aws/lambda/nodejs:14

ARG PROJECT_PATH=`pwd`
ARG PROJECT_NAME=`basename "$PROJECT_PATH"`
ARG TEMP_DIR=~/.lambdas/$PROJECT_NAME/

CMD mkdir -p $TEMP_DIR


CMD cd $TEMP_DIR

COPY package.json ./

CMD mkdir deploy

CMD npm install

COPY . $TEMP_DIR/.
CMD npm run build
CMD npm prune --production
# CMD zip -r $PROJECT_PATH/nest-lambda.zip . ../node_modules

RUN npm cache clean --force 

cmd cp ./dist/. ${LAMBDA_TASK_ROOT}/.
cmd cp ./node_modules ${LAMBDA_TASK_ROOT}/.

CMD [ "ls" "-ltr"]

CMD [ "cd" "${LAMBDA_TASK_ROOT}"]

CMD [ "ls" "-ltr"]

CMD [ "index.handler" ]
