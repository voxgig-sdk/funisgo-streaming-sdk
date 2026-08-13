
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'


import { FunisgoStreamingSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveDelay,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


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
      if (maybeSkipControl(t, 'entityOp', 'channel.' + op, live)) return
    }

    const setup = basicSetup()
    // The basic flow consumes synthetic IDs and field values from the
    // fixture (entity TestData.json). Those don't exist on the live API.
    // Skip live runs unless the user provided a real ENTID env override.
    if (setup.syntheticOnly) {
      t.skip('live entity test uses synthetic IDs from fixture — set FUNISGO_STREAMING_TEST_CHANNEL_ENTID JSON to run live')
      return
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

  // Detect whether the user provided a real ENTID JSON via env var. The
  // basic flow consumes synthetic IDs from the fixture file; without an
  // override those synthetic IDs reach the live API and 4xx. Surface this
  // to the test so it can skip rather than fail.
  const idmapEnvVal = process.env['FUNISGO_STREAMING_TEST_CHANNEL_ENTID']
  const idmapOverridden = null != idmapEnvVal && idmapEnvVal.trim().startsWith('{')

  const env = envOverride({
    'FUNISGO_STREAMING_TEST_CHANNEL_ENTID': idmap,
    'FUNISGO_STREAMING_TEST_LIVE': 'FALSE',
    'FUNISGO_STREAMING_TEST_EXPLAIN': 'FALSE',
    'FUNISGO_STREAMING_APIKEY': 'NONE',
  })

  idmap = env['FUNISGO_STREAMING_TEST_CHANNEL_ENTID']

  const live = 'TRUE' === env.FUNISGO_STREAMING_TEST_LIVE

  if (live) {
    client = new FunisgoStreamingSDK(merge([
      {
        apikey: env.FUNISGO_STREAMING_APIKEY,
      },
      extra
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
    syntheticOnly: live && !idmapOverridden,
    now: Date.now(),
  }

  return setup
}
  
