"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const node_path_1 = __importDefault(require("node:path"));
const Fs = __importStar(require("node:fs"));
const node_test_1 = require("node:test");
const node_assert_1 = __importDefault(require("node:assert"));
const live_runner_1 = require("../../live-runner");
const live_entity_1 = require("../../live-entity");
const __1 = require("../../..");
const utility_1 = require("../../utility");
// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
(0, utility_1.loadEnvLocal)(__dirname + '/../../../.env.local');
(0, node_test_1.describe)('MovieEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when FUNISGO_STREAMING_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('FUNISGO_STREAMING_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.FunisgoStreamingSDK.test();
        const ent = testsdk.Movie();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.FUNISGO_STREAMING_TEST_LIVE;
        for (const op of ['create', 'list', 'update', 'load', 'remove']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'movie.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": [{ "active": true, "format": "date-time", "name": "createdAt", "req": false, "type": "`$STRING`", "index$": 0 }, { "active": true, "name": "description", "op": { "create": { "req": true, "type": "`$STRING`" }, "update": { "req": true, "type": "`$STRING`" } }, "req": false, "type": "`$STRING`", "index$": 1 }, { "active": true, "name": "duration", "op": { "create": { "req": true, "type": "`$INTEGER`" }, "update": { "req": true, "type": "`$INTEGER`" } }, "req": false, "short": "Duration in minutes", "type": "`$INTEGER`", "index$": 2 }, { "active": true, "name": "genre", "op": { "create": { "req": true, "type": "`$ARRAY`" }, "update": { "req": true, "type": "`$ARRAY`" } }, "req": false, "type": "`$ARRAY`", "index$": 3 }, { "active": true, "name": "id", "req": false, "type": "`$STRING`", "index$": 4 }, { "active": true, "name": "isPremium", "req": false, "type": "`$BOOLEAN`", "index$": 5 }, { "active": true, "format": "float", "name": "rating", "req": false, "type": "`$NUMBER`", "index$": 6 }, { "active": true, "name": "releaseYear", "op": { "create": { "req": true, "type": "`$INTEGER`" }, "update": { "req": true, "type": "`$INTEGER`" } }, "req": false, "type": "`$INTEGER`", "index$": 7 }, { "active": true, "format": "uri", "name": "streamUrl", "req": false, "type": "`$STRING`", "index$": 8 }, { "active": true, "format": "uri", "name": "thumbnailUrl", "req": false, "type": "`$STRING`", "index$": 9 }, { "active": true, "name": "title", "op": { "create": { "req": true, "type": "`$STRING`" }, "update": { "req": true, "type": "`$STRING`" } }, "req": false, "type": "`$STRING`", "index$": 10 }, { "active": true, "format": "date-time", "name": "updatedAt", "req": false, "type": "`$STRING`", "index$": 11 }], "id": { "field": "id", "name": "id" }, "name": "movie", "op": { "create": { "input": "data", "name": "create", "points": [{ "active": true, "args": {}, "contract": { "id": "POST /movies", "json": "{\"operationId\":\"createMovie\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"description\":{\"example\":\"A computer hacker learns about the true nature of reality\",\"type\":\"string\"},\"duration\":{\"description\":\"Duration in minutes\",\"example\":136,\"type\":\"integer\"},\"genre\":{\"example\":[\"Action\",\"Sci-Fi\"],\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"isPremium\":{\"example\":false,\"type\":\"boolean\"},\"rating\":{\"example\":8.7,\"format\":\"float\",\"type\":\"number\"},\"releaseYear\":{\"example\":1999,\"type\":\"integer\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/movies/mov123456\",\"format\":\"uri\",\"type\":\"string\"},\"thumbnailUrl\":{\"example\":\"https://example.com/thumbnails/matrix.jpg\",\"format\":\"uri\",\"type\":\"string\"},\"title\":{\"example\":\"The Matrix\",\"type\":\"string\"}},\"required\":[\"title\",\"description\",\"genre\",\"releaseYear\",\"duration\"],\"type\":\"object\"}}},\"required\":true},\"responses\":{\"201\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"data\":{\"properties\":{\"createdAt\":{\"format\":\"date-time\",\"type\":\"string\"},\"description\":{\"example\":\"A computer hacker learns about the true nature of reality\",\"type\":\"string\"},\"duration\":{\"description\":\"Duration in minutes\",\"example\":136,\"type\":\"integer\"},\"genre\":{\"example\":[\"Action\",\"Sci-Fi\"],\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"id\":{\"example\":\"mov123456\",\"type\":\"string\"},\"isPremium\":{\"example\":false,\"type\":\"boolean\"},\"rating\":{\"example\":8.7,\"format\":\"float\",\"type\":\"number\"},\"releaseYear\":{\"example\":1999,\"type\":\"integer\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/movies/mov123456\",\"format\":\"uri\",\"type\":\"string\"},\"thumbnailUrl\":{\"example\":\"https://example.com/thumbnails/matrix.jpg\",\"format\":\"uri\",\"type\":\"string\"},\"title\":{\"example\":\"The Matrix\",\"type\":\"string\"},\"updatedAt\":{\"format\":\"date-time\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":true,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Movie created successfully\"},\"400\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"BAD_REQUEST\",\"message\":\"Invalid input parameters\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"The request was invalid or malformed\"},\"401\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"UNAUTHORIZED\",\"message\":\"Invalid or missing API key\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Authentication credentials are missing or invalid\"},\"403\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"FORBIDDEN\",\"message\":\"This operation requires a premium plan subscription\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Premium plan required for this operation\"}},\"security\":[{\"ApiKeyAuth\":[]}],\"securitySchemes\":{\"ApiKeyAuth\":{\"description\":\"API key for authentication. Free and premium plans available with different usage limits.\",\"in\":\"header\",\"name\":\"X-API-Key\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "POST", "orig": "/movies", "segments": [{ "lit": "movies" }], "select": {}, "transform": { "req": "`reqdata`", "res": "`body.data`" }, "index$": 0 }], "key$": "create" }, "list": { "input": "data", "name": "list", "points": [{ "active": true, "args": { "query": [{ "active": true, "kind": "query", "name": "genre", "orig": "genre", "reqd": false, "type": "`$STRING`", "index$": 0 }, { "active": true, "example": 20, "kind": "query", "name": "limit", "orig": "limit", "reqd": false, "type": "`$INTEGER`", "index$": 1 }, { "active": true, "example": 1, "kind": "query", "name": "page", "orig": "page", "reqd": false, "type": "`$INTEGER`", "index$": 2 }] }, "contract": { "id": "GET /movies", "json": "{\"operationId\":\"getMovies\",\"parameters\":[{\"description\":\"Page number for pagination\",\"in\":\"query\",\"name\":\"page\",\"required\":false,\"schema\":{\"default\":1,\"minimum\":1,\"type\":\"integer\"}},{\"description\":\"Number of items per page\",\"in\":\"query\",\"name\":\"limit\",\"required\":false,\"schema\":{\"default\":20,\"maximum\":100,\"minimum\":1,\"type\":\"integer\"}},{\"description\":\"Filter movies by genre\",\"in\":\"query\",\"name\":\"genre\",\"required\":false,\"schema\":{\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"data\":{\"items\":{\"properties\":{\"createdAt\":{\"format\":\"date-time\",\"type\":\"string\"},\"description\":{\"example\":\"A computer hacker learns about the true nature of reality\",\"type\":\"string\"},\"duration\":{\"description\":\"Duration in minutes\",\"example\":136,\"type\":\"integer\"},\"genre\":{\"example\":[\"Action\",\"Sci-Fi\"],\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"id\":{\"example\":\"mov123456\",\"type\":\"string\"},\"isPremium\":{\"example\":false,\"type\":\"boolean\"},\"rating\":{\"example\":8.7,\"format\":\"float\",\"type\":\"number\"},\"releaseYear\":{\"example\":1999,\"type\":\"integer\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/movies/mov123456\",\"format\":\"uri\",\"type\":\"string\"},\"thumbnailUrl\":{\"example\":\"https://example.com/thumbnails/matrix.jpg\",\"format\":\"uri\",\"type\":\"string\"},\"title\":{\"example\":\"The Matrix\",\"type\":\"string\"},\"updatedAt\":{\"format\":\"date-time\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"},\"pagination\":{\"properties\":{\"currentPage\":{\"example\":1,\"type\":\"integer\"},\"itemsPerPage\":{\"example\":20,\"type\":\"integer\"},\"totalItems\":{\"example\":200,\"type\":\"integer\"},\"totalPages\":{\"example\":10,\"type\":\"integer\"}},\"type\":\"object\"},\"success\":{\"example\":true,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Successful response with list of movies\"},\"401\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"UNAUTHORIZED\",\"message\":\"Invalid or missing API key\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Authentication credentials are missing or invalid\"},\"429\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"RATE_LIMIT_EXCEEDED\",\"message\":\"You have exceeded your API rate limit. Please upgrade to premium for higher limits.\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"API rate limit exceeded\"}},\"security\":[{\"ApiKeyAuth\":[]}],\"securitySchemes\":{\"ApiKeyAuth\":{\"description\":\"API key for authentication. Free and premium plans available with different usage limits.\",\"in\":\"header\",\"name\":\"X-API-Key\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "GET", "orig": "/movies", "segments": [{ "lit": "movies" }], "select": { "exist": ["genre", "limit", "page"] }, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "list" }, "load": { "input": "data", "name": "load", "points": [{ "active": true, "args": { "params": [{ "active": true, "kind": "param", "name": "id", "orig": "movie_id", "reqd": true, "type": "`$STRING`", "index$": 0 }] }, "contract": { "id": "GET /movies/{movieId}", "json": "{\"operationId\":\"getMovieById\",\"parameters\":[{\"description\":\"ID of the movie to retrieve\",\"in\":\"path\",\"name\":\"movieId\",\"required\":true,\"schema\":{\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"data\":{\"properties\":{\"createdAt\":{\"format\":\"date-time\",\"type\":\"string\"},\"description\":{\"example\":\"A computer hacker learns about the true nature of reality\",\"type\":\"string\"},\"duration\":{\"description\":\"Duration in minutes\",\"example\":136,\"type\":\"integer\"},\"genre\":{\"example\":[\"Action\",\"Sci-Fi\"],\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"id\":{\"example\":\"mov123456\",\"type\":\"string\"},\"isPremium\":{\"example\":false,\"type\":\"boolean\"},\"rating\":{\"example\":8.7,\"format\":\"float\",\"type\":\"number\"},\"releaseYear\":{\"example\":1999,\"type\":\"integer\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/movies/mov123456\",\"format\":\"uri\",\"type\":\"string\"},\"thumbnailUrl\":{\"example\":\"https://example.com/thumbnails/matrix.jpg\",\"format\":\"uri\",\"type\":\"string\"},\"title\":{\"example\":\"The Matrix\",\"type\":\"string\"},\"updatedAt\":{\"format\":\"date-time\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":true,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Successful response with movie details\"},\"401\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"UNAUTHORIZED\",\"message\":\"Invalid or missing API key\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Authentication credentials are missing or invalid\"},\"404\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"NOT_FOUND\",\"message\":\"The requested resource was not found\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"The requested resource was not found\"}},\"security\":[{\"ApiKeyAuth\":[]}],\"securitySchemes\":{\"ApiKeyAuth\":{\"description\":\"API key for authentication. Free and premium plans available with different usage limits.\",\"in\":\"header\",\"name\":\"X-API-Key\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "GET", "orig": "/movies/{movieId}", "rename": { "param": { "movieId": "id" } }, "segments": [{ "lit": "movies" }, { "var": "id" }], "select": { "exist": ["id"] }, "transform": { "req": "`reqdata`", "res": "`body.data`" }, "index$": 0 }], "key$": "load" }, "remove": { "input": "data", "name": "remove", "points": [{ "active": true, "args": { "params": [{ "active": true, "kind": "param", "name": "id", "orig": "movie_id", "reqd": true, "type": "`$STRING`", "index$": 0 }] }, "contract": { "id": "DELETE /movies/{movieId}", "json": "{\"operationId\":\"deleteMovie\",\"parameters\":[{\"description\":\"ID of the movie to delete\",\"in\":\"path\",\"name\":\"movieId\",\"required\":true,\"schema\":{\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"message\":{\"example\":\"Movie deleted successfully\",\"type\":\"string\"},\"success\":{\"example\":true,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Movie deleted successfully\"},\"401\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"UNAUTHORIZED\",\"message\":\"Invalid or missing API key\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Authentication credentials are missing or invalid\"},\"403\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"FORBIDDEN\",\"message\":\"This operation requires a premium plan subscription\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Premium plan required for this operation\"},\"404\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"NOT_FOUND\",\"message\":\"The requested resource was not found\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"The requested resource was not found\"}},\"security\":[{\"ApiKeyAuth\":[]}],\"securitySchemes\":{\"ApiKeyAuth\":{\"description\":\"API key for authentication. Free and premium plans available with different usage limits.\",\"in\":\"header\",\"name\":\"X-API-Key\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "DELETE", "orig": "/movies/{movieId}", "rename": { "param": { "movieId": "id" } }, "segments": [{ "lit": "movies" }, { "var": "id" }], "select": { "exist": ["id"] }, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "remove" }, "update": { "input": "data", "name": "update", "points": [{ "active": true, "args": { "params": [{ "active": true, "kind": "param", "name": "id", "orig": "movie_id", "reqd": true, "type": "`$STRING`", "index$": 0 }] }, "contract": { "id": "PUT /movies/{movieId}", "json": "{\"operationId\":\"updateMovie\",\"parameters\":[{\"description\":\"ID of the movie to update\",\"in\":\"path\",\"name\":\"movieId\",\"required\":true,\"schema\":{\"type\":\"string\"}}],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"description\":{\"example\":\"A computer hacker learns about the true nature of reality\",\"type\":\"string\"},\"duration\":{\"description\":\"Duration in minutes\",\"example\":136,\"type\":\"integer\"},\"genre\":{\"example\":[\"Action\",\"Sci-Fi\"],\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"isPremium\":{\"example\":false,\"type\":\"boolean\"},\"rating\":{\"example\":8.7,\"format\":\"float\",\"type\":\"number\"},\"releaseYear\":{\"example\":1999,\"type\":\"integer\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/movies/mov123456\",\"format\":\"uri\",\"type\":\"string\"},\"thumbnailUrl\":{\"example\":\"https://example.com/thumbnails/matrix.jpg\",\"format\":\"uri\",\"type\":\"string\"},\"title\":{\"example\":\"The Matrix\",\"type\":\"string\"}},\"required\":[\"title\",\"description\",\"genre\",\"releaseYear\",\"duration\"],\"type\":\"object\"}}},\"required\":true},\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"data\":{\"properties\":{\"createdAt\":{\"format\":\"date-time\",\"type\":\"string\"},\"description\":{\"example\":\"A computer hacker learns about the true nature of reality\",\"type\":\"string\"},\"duration\":{\"description\":\"Duration in minutes\",\"example\":136,\"type\":\"integer\"},\"genre\":{\"example\":[\"Action\",\"Sci-Fi\"],\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"id\":{\"example\":\"mov123456\",\"type\":\"string\"},\"isPremium\":{\"example\":false,\"type\":\"boolean\"},\"rating\":{\"example\":8.7,\"format\":\"float\",\"type\":\"number\"},\"releaseYear\":{\"example\":1999,\"type\":\"integer\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/movies/mov123456\",\"format\":\"uri\",\"type\":\"string\"},\"thumbnailUrl\":{\"example\":\"https://example.com/thumbnails/matrix.jpg\",\"format\":\"uri\",\"type\":\"string\"},\"title\":{\"example\":\"The Matrix\",\"type\":\"string\"},\"updatedAt\":{\"format\":\"date-time\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":true,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Movie updated successfully\"},\"400\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"BAD_REQUEST\",\"message\":\"Invalid input parameters\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"The request was invalid or malformed\"},\"401\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"UNAUTHORIZED\",\"message\":\"Invalid or missing API key\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Authentication credentials are missing or invalid\"},\"403\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"FORBIDDEN\",\"message\":\"This operation requires a premium plan subscription\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Premium plan required for this operation\"},\"404\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"NOT_FOUND\",\"message\":\"The requested resource was not found\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"The requested resource was not found\"}},\"security\":[{\"ApiKeyAuth\":[]}],\"securitySchemes\":{\"ApiKeyAuth\":{\"description\":\"API key for authentication. Free and premium plans available with different usage limits.\",\"in\":\"header\",\"name\":\"X-API-Key\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "PUT", "orig": "/movies/{movieId}", "rename": { "param": { "movieId": "id" } }, "segments": [{ "lit": "movies" }, { "var": "id" }], "select": { "exist": ["id"] }, "transform": { "req": "`reqdata`", "res": "`body.data`" }, "index$": 0 }], "key$": "update" } }, "relations": { "ancestors": [] }, "key$": "movie", "name__orig": "movie", "Name": "Movie", "name_": "movie", "name-": "movie", "NAME": "MOVIE", "index$": 1 }, { "active": true, "entity": "movie", "key$": "BasicMovieFlow", "kind": "basic", "name": "BasicMovieFlow", "param": {}, "step": [{ "active": true, "data": {}, "input": { "ref": "movie_ref01" }, "match": {}, "op": "create", "spec": [], "valid": [], "index$": 0 }, { "active": true, "data": {}, "input": {}, "match": {}, "op": "list", "spec": [], "valid": [{ "apply": "ItemExists", "def": { "ref": "movie_ref01" } }], "index$": 1 }, { "active": true, "data": {}, "input": { "ref": "movie_ref01", "srcdatavar": "movie_ref01_data", "suffix": "_up0", "textfield": "createdAt" }, "match": {}, "op": "update", "spec": [{ "apply": "TextFieldMark", "def": { "mark": "Mark01-movie_ref01" } }], "valid": [], "index$": 2 }, { "active": true, "data": {}, "input": { "ref": "movie_ref01", "srcdatavar": "movie_ref01_data", "suffix": "_dt0" }, "match": { "id": "movie01" }, "op": "load", "spec": [], "valid": [{ "apply": "TextFieldMark", "def": { "mark": "Mark01-movie_ref01" } }], "index$": 3 }, { "active": true, "data": {}, "input": { "ref": "movie_ref01", "suffix": "_rm0" }, "match": { "id": "movie01" }, "op": "remove", "spec": [], "valid": [], "index$": 4 }, { "active": true, "data": {}, "input": { "suffix": "_rt0" }, "match": {}, "op": "list", "spec": [], "valid": [{ "apply": "ItemNotExists", "def": { "ref": "movie_ref01" } }], "index$": 5 }] }, 'Movie');
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        // CREATE
        const movie_ref01_ent = client.Movie();
        let movie_ref01_data = setup.data.new.movie['movie_ref01'];
        movie_ref01_data = (await movie_ref01_ent.create(movie_ref01_data)).data();
        (0, node_assert_1.default)(null != movie_ref01_data.id);
        // LIST
        const movie_ref01_match = {};
        const movie_ref01_list = (await movie_ref01_ent.list(movie_ref01_match)).map((e) => e.data());
        (0, node_assert_1.default)(!isempty(select(movie_ref01_list, { id: movie_ref01_data.id })));
        // UPDATE
        const movie_ref01_data_up0 = {};
        movie_ref01_data_up0.id = movie_ref01_data.id;
        const movie_ref01_markdef_up0 = { name: 'createdAt', value: 'Mark01-movie_ref01_' + setup.now };
        movie_ref01_data_up0[movie_ref01_markdef_up0.name] = movie_ref01_markdef_up0.value;
        const movie_ref01_resdata_up0 = (await movie_ref01_ent.update(movie_ref01_data_up0)).data();
        (0, node_assert_1.default)(movie_ref01_resdata_up0.id === movie_ref01_data_up0.id);
        (0, node_assert_1.default)(movie_ref01_resdata_up0[movie_ref01_markdef_up0.name] === movie_ref01_markdef_up0.value);
        // LOAD
        const movie_ref01_match_dt0 = {};
        movie_ref01_match_dt0.id = movie_ref01_data.id;
        const movie_ref01_data_dt0 = (await movie_ref01_ent.load(movie_ref01_match_dt0)).data();
        (0, node_assert_1.default)(movie_ref01_data_dt0.id === movie_ref01_data.id);
        // REMOVE
        const movie_ref01_match_rm0 = { id: movie_ref01_data.id };
        await movie_ref01_ent.remove(movie_ref01_match_rm0);
        // LIST
        const movie_ref01_match_rt0 = {};
        const movie_ref01_list_rt0 = (await movie_ref01_ent.list(movie_ref01_match_rt0)).map((e) => e.data());
        (0, node_assert_1.default)(isempty(select(movie_ref01_list_rt0, { id: movie_ref01_data.id })));
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/movie/MovieTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.FunisgoStreamingSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['movie01', 'movie02', 'movie03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'FUNISGO_STREAMING_TEST_MOVIE_ENTID': idmap,
        'FUNISGO_STREAMING_TEST_LIVE': 'FALSE',
        'FUNISGO_STREAMING_TEST_EXPLAIN': 'FALSE',
        'FUNISGO_STREAMING_APIKEY': '',
    });
    idmap = env['FUNISGO_STREAMING_TEST_MOVIE_ENTID'];
    const live = 'TRUE' === env.FUNISGO_STREAMING_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['FUNISGO_STREAMING_TEST_MOVIE_ENTID'];
        idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {};
        if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
            throw new Error('Live ENTID must be a JSON object');
        }
        client = new __1.FunisgoStreamingSDK(merge([
            // FIRST, so the generated fields below win: sdk-test-control.json's
            // test.client.options adds to the live client, it does not redirect it.
            (0, utility_1.liveClientOptions)(),
            {
                apikey: env.FUNISGO_STREAMING_APIKEY,
            },
            // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
            // last entry is undefined, and basicSetup is normally called with no
            // argument at all - so a bare 'extra' silently discarded the apikey
            // and server values above and handed the SDK undefined. Harmless
            // while there was nothing in that object; not harmless now.
            extra || {},
            { system: { fetch: transport.fetch } }
        ]));
    }
    const setup = {
        idmap,
        env,
        options,
        client,
        struct,
        data: entityData,
        explain: 'TRUE' === env.FUNISGO_STREAMING_TEST_EXPLAIN,
        live,
        transport,
        now: Date.now(),
    };
    return setup;
}
//# sourceMappingURL=MovieEntity.test.js.map