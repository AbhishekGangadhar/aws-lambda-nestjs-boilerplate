PROJECT_PATH=`pwd`
PROJECT_NAME=`basename "$PROJECT_PATH"`
TEMP_DIR=~/.lambdas/$PROJECT_NAME/

echo $TEMP_DIR

mkdir -p $TEMP_DIR
rsync -ha --progress . $TEMP_DIR
cd $TEMP_DIR
mkdir deploy
npm install
npm run build
npm prune --production
cd dist
zip -r $PROJECT_PATH/nest-lambda.zip . ../node_modules

