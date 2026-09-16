

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { FunisgoStreamingSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
loadEnvLocal(__dirname + '/../../../.env.local')


describe('ChannelEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when FUNISGO_STREAMING_TEST_LIVE=TRUE.
  afterEach(liveDelay('FUNISGO_STREAMING_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = FunisgoStreamingSDK.test()
    const ent = testsdk.Channel()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.FUNISGO_STREAMING_TEST_LIVE
    for (const op of ['create', 'list', 'update', 'load', 'remove']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'channel.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"name":"category","op":{"create":{"req":true,"type":"`$STRING`"},"update":{"req":true,"type":"`$STRING`"}},"req":false,"type":"`$STRING`","index$":0},{"active":true,"format":"date-time","name":"createdAt","req":false,"type":"`$STRING`","index$":1},{"active":true,"name":"description","op":{"create":{"req":true,"type":"`$STRING`"},"update":{"req":true,"type":"`$STRING`"}},"req":false,"type":"`$STRING`","index$":2},{"active":true,"name":"id","req":false,"type":"`$STRING`","index$":3},{"active":true,"name":"isLive","req":false,"type":"`$BOOLEAN`","index$":4},{"active":true,"name":"isPremium","req":false,"type":"`$BOOLEAN`","index$":5},{"active":true,"name":"language","req":false,"type":"`$STRING`","index$":6},{"active":true,"format":"uri","name":"logoUrl","req":false,"type":"`$STRING`","index$":7},{"active":true,"name":"name","op":{"create":{"req":true,"type":"`$STRING`"},"update":{"req":true,"type":"`$STRING`"}},"req":false,"type":"`$STRING`","index$":8},{"active":true,"format":"uri","name":"streamUrl","req":false,"type":"`$STRING`","index$":9},{"active":true,"format":"date-time","name":"updatedAt","req":false,"type":"`$STRING`","index$":10}],"id":{"field":"id","name":"id"},"name":"channel","op":{"create":{"input":"data","name":"create","points":[{"active":true,"args":{},"contract":{"id":"POST /channels","json":"{\"operationId\":\"createChannel\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"category\":{\"example\":\"Sports\",\"type\":\"string\"},\"description\":{\"example\":\"24/7 sports streaming channel\",\"type\":\"string\"},\"isLive\":{\"example\":true,\"type\":\"boolean\"},\"isPremium\":{\"example\":true,\"type\":\"boolean\"},\"language\":{\"example\":\"English\",\"type\":\"string\"},\"logoUrl\":{\"example\":\"https://example.com/logos/sports-channel.png\",\"format\":\"uri\",\"type\":\"string\"},\"name\":{\"example\":\"FunisGo Sports\",\"type\":\"string\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/channels/ch123456\",\"format\":\"uri\",\"type\":\"string\"}},\"required\":[\"name\",\"description\",\"category\"],\"type\":\"object\"}}},\"required\":true},\"responses\":{\"201\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"data\":{\"properties\":{\"category\":{\"example\":\"Sports\",\"type\":\"string\"},\"createdAt\":{\"format\":\"date-time\",\"type\":\"string\"},\"description\":{\"example\":\"24/7 sports streaming channel\",\"type\":\"string\"},\"id\":{\"example\":\"ch123456\",\"type\":\"string\"},\"isLive\":{\"example\":true,\"type\":\"boolean\"},\"isPremium\":{\"example\":true,\"type\":\"boolean\"},\"language\":{\"example\":\"English\",\"type\":\"string\"},\"logoUrl\":{\"example\":\"https://example.com/logos/sports-channel.png\",\"format\":\"uri\",\"type\":\"string\"},\"name\":{\"example\":\"FunisGo Sports\",\"type\":\"string\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/channels/ch123456\",\"format\":\"uri\",\"type\":\"string\"},\"updatedAt\":{\"format\":\"date-time\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":true,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Channel created successfully\"},\"400\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"BAD_REQUEST\",\"message\":\"Invalid input parameters\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"The request was invalid or malformed\"},\"401\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"UNAUTHORIZED\",\"message\":\"Invalid or missing API key\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Authentication credentials are missing or invalid\"},\"403\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"FORBIDDEN\",\"message\":\"This operation requires a premium plan subscription\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Premium plan required for this operation\"}},\"security\":[{\"ApiKeyAuth\":[]}],\"securitySchemes\":{\"ApiKeyAuth\":{\"description\":\"API key for authentication. Free and premium plans available with different usage limits.\",\"in\":\"header\",\"name\":\"X-API-Key\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}","source":"openapi3","version":1},"kind":"http","method":"POST","orig":"/channels","segments":[{"lit":"channels"}],"select":{},"transform":{"req":"`reqdata`","res":"`body.data`"},"index$":0}],"key$":"create"},"list":{"input":"data","name":"list","points":[{"active":true,"args":{"query":[{"active":true,"kind":"query","name":"category","orig":"category","reqd":false,"type":"`$STRING`","index$":0},{"active":true,"example":20,"kind":"query","name":"limit","orig":"limit","reqd":false,"type":"`$INTEGER`","index$":1},{"active":true,"example":1,"kind":"query","name":"page","orig":"page","reqd":false,"type":"`$INTEGER`","index$":2}]},"contract":{"id":"GET /channels","json":"{\"operationId\":\"getChannels\",\"parameters\":[{\"description\":\"Page number for pagination\",\"in\":\"query\",\"name\":\"page\",\"required\":false,\"schema\":{\"default\":1,\"minimum\":1,\"type\":\"integer\"}},{\"description\":\"Number of items per page\",\"in\":\"query\",\"name\":\"limit\",\"required\":false,\"schema\":{\"default\":20,\"maximum\":100,\"minimum\":1,\"type\":\"integer\"}},{\"description\":\"Filter channels by category\",\"in\":\"query\",\"name\":\"category\",\"required\":false,\"schema\":{\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"data\":{\"items\":{\"properties\":{\"category\":{\"example\":\"Sports\",\"type\":\"string\"},\"createdAt\":{\"format\":\"date-time\",\"type\":\"string\"},\"description\":{\"example\":\"24/7 sports streaming channel\",\"type\":\"string\"},\"id\":{\"example\":\"ch123456\",\"type\":\"string\"},\"isLive\":{\"example\":true,\"type\":\"boolean\"},\"isPremium\":{\"example\":true,\"type\":\"boolean\"},\"language\":{\"example\":\"English\",\"type\":\"string\"},\"logoUrl\":{\"example\":\"https://example.com/logos/sports-channel.png\",\"format\":\"uri\",\"type\":\"string\"},\"name\":{\"example\":\"FunisGo Sports\",\"type\":\"string\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/channels/ch123456\",\"format\":\"uri\",\"type\":\"string\"},\"updatedAt\":{\"format\":\"date-time\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"},\"pagination\":{\"properties\":{\"currentPage\":{\"example\":1,\"type\":\"integer\"},\"itemsPerPage\":{\"example\":20,\"type\":\"integer\"},\"totalItems\":{\"example\":200,\"type\":\"integer\"},\"totalPages\":{\"example\":10,\"type\":\"integer\"}},\"type\":\"object\"},\"success\":{\"example\":true,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Successful response with list of channels\"},\"401\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"UNAUTHORIZED\",\"message\":\"Invalid or missing API key\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Authentication credentials are missing or invalid\"},\"429\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"RATE_LIMIT_EXCEEDED\",\"message\":\"You have exceeded your API rate limit. Please upgrade to premium for higher limits.\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"API rate limit exceeded\"}},\"security\":[{\"ApiKeyAuth\":[]}],\"securitySchemes\":{\"ApiKeyAuth\":{\"description\":\"API key for authentication. Free and premium plans available with different usage limits.\",\"in\":\"header\",\"name\":\"X-API-Key\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/channels","segments":[{"lit":"channels"}],"select":{"exist":["category","limit","page"]},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"list"},"load":{"input":"data","name":"load","points":[{"active":true,"args":{"params":[{"active":true,"kind":"param","name":"id","orig":"channel_id","reqd":true,"type":"`$STRING`","index$":0}]},"contract":{"id":"GET /channels/{channelId}","json":"{\"operationId\":\"getChannelById\",\"parameters\":[{\"description\":\"ID of the channel to retrieve\",\"in\":\"path\",\"name\":\"channelId\",\"required\":true,\"schema\":{\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"data\":{\"properties\":{\"category\":{\"example\":\"Sports\",\"type\":\"string\"},\"createdAt\":{\"format\":\"date-time\",\"type\":\"string\"},\"description\":{\"example\":\"24/7 sports streaming channel\",\"type\":\"string\"},\"id\":{\"example\":\"ch123456\",\"type\":\"string\"},\"isLive\":{\"example\":true,\"type\":\"boolean\"},\"isPremium\":{\"example\":true,\"type\":\"boolean\"},\"language\":{\"example\":\"English\",\"type\":\"string\"},\"logoUrl\":{\"example\":\"https://example.com/logos/sports-channel.png\",\"format\":\"uri\",\"type\":\"string\"},\"name\":{\"example\":\"FunisGo Sports\",\"type\":\"string\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/channels/ch123456\",\"format\":\"uri\",\"type\":\"string\"},\"updatedAt\":{\"format\":\"date-time\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":true,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Successful response with channel details\"},\"401\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"UNAUTHORIZED\",\"message\":\"Invalid or missing API key\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Authentication credentials are missing or invalid\"},\"404\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"NOT_FOUND\",\"message\":\"The requested resource was not found\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"The requested resource was not found\"}},\"security\":[{\"ApiKeyAuth\":[]}],\"securitySchemes\":{\"ApiKeyAuth\":{\"description\":\"API key for authentication. Free and premium plans available with different usage limits.\",\"in\":\"header\",\"name\":\"X-API-Key\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/channels/{channelId}","rename":{"param":{"channelId":"id"}},"segments":[{"lit":"channels"},{"var":"id"}],"select":{"exist":["id"]},"transform":{"req":"`reqdata`","res":"`body.data`"},"index$":0}],"key$":"load"},"remove":{"input":"data","name":"remove","points":[{"active":true,"args":{"params":[{"active":true,"kind":"param","name":"id","orig":"channel_id","reqd":true,"type":"`$STRING`","index$":0}]},"contract":{"id":"DELETE /channels/{channelId}","json":"{\"operationId\":\"deleteChannel\",\"parameters\":[{\"description\":\"ID of the channel to delete\",\"in\":\"path\",\"name\":\"channelId\",\"required\":true,\"schema\":{\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"message\":{\"example\":\"Channel deleted successfully\",\"type\":\"string\"},\"success\":{\"example\":true,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Channel deleted successfully\"},\"401\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"UNAUTHORIZED\",\"message\":\"Invalid or missing API key\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Authentication credentials are missing or invalid\"},\"403\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"FORBIDDEN\",\"message\":\"This operation requires a premium plan subscription\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Premium plan required for this operation\"},\"404\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"NOT_FOUND\",\"message\":\"The requested resource was not found\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"The requested resource was not found\"}},\"security\":[{\"ApiKeyAuth\":[]}],\"securitySchemes\":{\"ApiKeyAuth\":{\"description\":\"API key for authentication. Free and premium plans available with different usage limits.\",\"in\":\"header\",\"name\":\"X-API-Key\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}","source":"openapi3","version":1},"kind":"http","method":"DELETE","orig":"/channels/{channelId}","rename":{"param":{"channelId":"id"}},"segments":[{"lit":"channels"},{"var":"id"}],"select":{"exist":["id"]},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"remove"},"update":{"input":"data","name":"update","points":[{"active":true,"args":{"params":[{"active":true,"kind":"param","name":"id","orig":"channel_id","reqd":true,"type":"`$STRING`","index$":0}]},"contract":{"id":"PUT /channels/{channelId}","json":"{\"operationId\":\"updateChannel\",\"parameters\":[{\"description\":\"ID of the channel to update\",\"in\":\"path\",\"name\":\"channelId\",\"required\":true,\"schema\":{\"type\":\"string\"}}],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"category\":{\"example\":\"Sports\",\"type\":\"string\"},\"description\":{\"example\":\"24/7 sports streaming channel\",\"type\":\"string\"},\"isLive\":{\"example\":true,\"type\":\"boolean\"},\"isPremium\":{\"example\":true,\"type\":\"boolean\"},\"language\":{\"example\":\"English\",\"type\":\"string\"},\"logoUrl\":{\"example\":\"https://example.com/logos/sports-channel.png\",\"format\":\"uri\",\"type\":\"string\"},\"name\":{\"example\":\"FunisGo Sports\",\"type\":\"string\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/channels/ch123456\",\"format\":\"uri\",\"type\":\"string\"}},\"required\":[\"name\",\"description\",\"category\"],\"type\":\"object\"}}},\"required\":true},\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"data\":{\"properties\":{\"category\":{\"example\":\"Sports\",\"type\":\"string\"},\"createdAt\":{\"format\":\"date-time\",\"type\":\"string\"},\"description\":{\"example\":\"24/7 sports streaming channel\",\"type\":\"string\"},\"id\":{\"example\":\"ch123456\",\"type\":\"string\"},\"isLive\":{\"example\":true,\"type\":\"boolean\"},\"isPremium\":{\"example\":true,\"type\":\"boolean\"},\"language\":{\"example\":\"English\",\"type\":\"string\"},\"logoUrl\":{\"example\":\"https://example.com/logos/sports-channel.png\",\"format\":\"uri\",\"type\":\"string\"},\"name\":{\"example\":\"FunisGo Sports\",\"type\":\"string\"},\"streamUrl\":{\"example\":\"https://stream.funisgo.com/channels/ch123456\",\"format\":\"uri\",\"type\":\"string\"},\"updatedAt\":{\"format\":\"date-time\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":true,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Channel updated successfully\"},\"400\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"BAD_REQUEST\",\"message\":\"Invalid input parameters\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"The request was invalid or malformed\"},\"401\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"UNAUTHORIZED\",\"message\":\"Invalid or missing API key\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Authentication credentials are missing or invalid\"},\"403\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"FORBIDDEN\",\"message\":\"This operation requires a premium plan subscription\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Premium plan required for this operation\"},\"404\":{\"content\":{\"application/json\":{\"example\":{\"error\":{\"code\":\"NOT_FOUND\",\"message\":\"The requested resource was not found\"},\"success\":false},\"schema\":{\"properties\":{\"error\":{\"properties\":{\"code\":{\"example\":\"INVALID_REQUEST\",\"type\":\"string\"},\"message\":{\"example\":\"The request was invalid or malformed\",\"type\":\"string\"}},\"type\":\"object\"},\"success\":{\"example\":false,\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"The requested resource was not found\"}},\"security\":[{\"ApiKeyAuth\":[]}],\"securitySchemes\":{\"ApiKeyAuth\":{\"description\":\"API key for authentication. Free and premium plans available with different usage limits.\",\"in\":\"header\",\"name\":\"X-API-Key\",\"type\":\"apiKey\"}},\"securitySource\":\"operation\"}","source":"openapi3","version":1},"kind":"http","method":"PUT","orig":"/channels/{channelId}","rename":{"param":{"channelId":"id"}},"segments":[{"lit":"channels"},{"var":"id"}],"select":{"exist":["id"]},"transform":{"req":"`reqdata`","res":"`body.data`"},"index$":0}],"key$":"update"}},"relations":{"ancestors":[]},"key$":"channel","name__orig":"channel","Name":"Channel","name_":"channel","name-":"channel","NAME":"CHANNEL","index$":0}, {"active":true,"entity":"channel","key$":"BasicChannelFlow","kind":"basic","name":"BasicChannelFlow","param":{},"step":[{"active":true,"data":{},"input":{"ref":"channel_ref01"},"match":{},"op":"create","spec":[],"valid":[],"index$":0},{"active":true,"data":{},"input":{},"match":{},"op":"list","spec":[],"valid":[{"apply":"ItemExists","def":{"ref":"channel_ref01"}}],"index$":1},{"active":true,"data":{},"input":{"ref":"channel_ref01","srcdatavar":"channel_ref01_data","suffix":"_up0","textfield":"category"},"match":{},"op":"update","spec":[{"apply":"TextFieldMark","def":{"mark":"Mark01-channel_ref01"}}],"valid":[],"index$":2},{"active":true,"data":{},"input":{"ref":"channel_ref01","srcdatavar":"channel_ref01_data","suffix":"_dt0"},"match":{"id":"channel01"},"op":"load","spec":[],"valid":[{"apply":"TextFieldMark","def":{"mark":"Mark01-channel_ref01"}}],"index$":3},{"active":true,"data":{},"input":{"ref":"channel_ref01","suffix":"_rm0"},"match":{"id":"channel01"},"op":"remove","spec":[],"valid":[],"index$":4},{"active":true,"data":{},"input":{"suffix":"_rt0"},"match":{},"op":"list","spec":[],"valid":[{"apply":"ItemNotExists","def":{"ref":"channel_ref01"}}],"index$":5}]}, 'Channel')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const channel_ref01_ent = client.Channel()
    let channel_ref01_data = setup.data.new.channel['channel_ref01']

    channel_ref01_data = (await channel_ref01_ent.create(channel_ref01_data)).data()
    assert(null != channel_ref01_data.id)


    // LIST
    const channel_ref01_match: any = {}

    const channel_ref01_list = (await channel_ref01_ent.list(channel_ref01_match)).map((e: any) => e.data())

    assert(!isempty(select(channel_ref01_list, { id: channel_ref01_data.id })))


    // UPDATE
    const channel_ref01_data_up0: any = {}
    channel_ref01_data_up0.id = channel_ref01_data.id

    const channel_ref01_markdef_up0 = { name: 'category', value: 'Mark01-channel_ref01_' + setup.now }
    ;(channel_ref01_data_up0 as any)[channel_ref01_markdef_up0.name] = channel_ref01_markdef_up0.value

    const channel_ref01_resdata_up0 = (await channel_ref01_ent.update(channel_ref01_data_up0)).data()
    assert(channel_ref01_resdata_up0.id === channel_ref01_data_up0.id)

    assert((channel_ref01_resdata_up0 as any)[channel_ref01_markdef_up0.name] === channel_ref01_markdef_up0.value)


    // LOAD
    const channel_ref01_match_dt0: any = {}
    channel_ref01_match_dt0.id = channel_ref01_data.id
    const channel_ref01_data_dt0 = (await channel_ref01_ent.load(channel_ref01_match_dt0)).data()
    assert(channel_ref01_data_dt0.id === channel_ref01_data.id)


    // REMOVE
    const channel_ref01_match_rm0: any = { id: channel_ref01_data.id }
    await channel_ref01_ent.remove(channel_ref01_match_rm0)
  

    // LIST
    const channel_ref01_match_rt0: any = {}

    const channel_ref01_list_rt0 = (await channel_ref01_ent.list(channel_ref01_match_rt0)).map((e: any) => e.data())

    assert(isempty(select(channel_ref01_list_rt0, { id: channel_ref01_data.id })))


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/channel/ChannelTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = FunisgoStreamingSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['channel01','channel02','channel03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'FUNISGO_STREAMING_TEST_CHANNEL_ENTID': idmap,
    'FUNISGO_STREAMING_TEST_LIVE': 'FALSE',
    'FUNISGO_STREAMING_TEST_EXPLAIN': 'FALSE',
    'FUNISGO_STREAMING_APIKEY': '',
  })

  idmap = env['FUNISGO_STREAMING_TEST_CHANNEL_ENTID']

  const live = 'TRUE' === env.FUNISGO_STREAMING_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['FUNISGO_STREAMING_TEST_CHANNEL_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new FunisgoStreamingSDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
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
    ]))
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
  }

  return setup
}
  
