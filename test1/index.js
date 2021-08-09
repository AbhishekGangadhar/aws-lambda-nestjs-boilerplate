"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.handler = exports.createApp = void 0;
const core_1 = require("@nestjs/core");
const platform_express_1 = require("@nestjs/platform-express");
const app_module_1 = require("./src/app.module");
const express = require("express");
const aws_serverless_express_1 = require("aws-serverless-express");
async function createApp(expressApp) {
    return await core_1.NestFactory.create(app_module_1.AppModule, new platform_express_1.ExpressAdapter(expressApp));
}
exports.createApp = createApp;
let cachedServer;
async function bootstrap() {
    const expressApp = express();
    const app = await createApp(expressApp);
    await app.init();
    app.enableCors();
    return aws_serverless_express_1.createServer(expressApp);
}
async function handler(event, context) {
    if (!cachedServer) {
        cachedServer = await bootstrap();
    }
    return aws_serverless_express_1.proxy(cachedServer, event, context, 'PROMISE').promise;
}
exports.handler = handler;
//# sourceMappingURL=index.js.map