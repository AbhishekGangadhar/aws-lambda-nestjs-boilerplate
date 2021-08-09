# FROM amazon/aws-lambda-nodejs:12
FROM public.ecr.aws/lambda/nodejs:14

ARG PROJECT_NAME=test
ARG TEMP_DIR=~/.lambdas/$PROJECT_NAME/

CMD mkdir -p $TEMP_DIR


CMD cd $TEMP_DIR

COPY package.json ./
CMD npm install

CMD mkdir deploy
COPY . $TEMP_DIR/.
CMD npm run build
CMD npm prune --production
# CMD zip -r $PROJECT_PATH/nest-lambda.zip . ../node_modules

RUN npm cache clean --force 

CMD cp ./dist/. ${LAMBDA_TASK_ROOT}/.
CMD cp ./node_modules ${LAMBDA_TASK_ROOT}/.

CMD [ "ls" "-ltr"]

CMD [ "cd" "${LAMBDA_TASK_ROOT}"]

CMD [ "ls" "-ltr"]

CMD [ "index.handler" ]
