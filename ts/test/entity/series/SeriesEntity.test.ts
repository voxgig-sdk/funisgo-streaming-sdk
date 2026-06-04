
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


describe('SeriesEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when FUNISGOSTREAMING_TEST_LIVE=TRUE.
  afterEach(liveDelay('FUNISGOSTREAMING_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = FunisgoStreamingSDK.test()
    const ent = testsdk.Series()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.FUNISGO_STREAMING_TEST_LIVE
    for (const op of ['create', 'list', 'update', 'load', 'remove']) {
      if (maybeSkipControl(t, 'entityOp', 'series.' + op, live)) return
    }

    const setup = basicSetup()
    // The basic flow consumes synthetic IDs and field values from the
    // fixture (entity TestData.json). Those don't exist on the live API.
    // Skip live runs unless the user provided a real ENTID env override.
    if (setup.syntheticOnly) {
      t.skip('live entity test uses synthetic IDs from fixture — set FUNISGO_STREAMING_TEST_SERIES_ENTID JSON to run live')
      return
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const series_ref01_ent = client.Series()
    let series_ref01_data = setup.data.new.series['series_ref01']

    series_ref01_data = await series_ref01_ent.create(series_ref01_data)
    assert(null != series_ref01_data.id)


    // LIST
    const series_ref01_match: any = {}

    const series_ref01_list = await series_ref01_ent.list(series_ref01_match)

    assert(!isempty(select(series_ref01_list, { id: series_ref01_data.id })))


    // UPDATE
    const series_ref01_data_up0: any = {}
    series_ref01_data_up0.id = series_ref01_data.id

    const series_ref01_markdef_up0 = { name: 'created_at', value: 'Mark01-series_ref01_' + setup.now }
    series_ref01_data_up0 [series_ref01_markdef_up0.name] = series_ref01_markdef_up0.value

    const series_ref01_resdata_up0 = await series_ref01_ent.update(series_ref01_data_up0)
    assert(series_ref01_resdata_up0.id === series_ref01_data_up0.id)

    assert(series_ref01_resdata_up0[series_ref01_markdef_up0.name] === series_ref01_markdef_up0.value)


    // LOAD
    const series_ref01_match_dt0: any = {}
    series_ref01_match_dt0.id = series_ref01_data.id
    const series_ref01_data_dt0 = await series_ref01_ent.load(series_ref01_match_dt0)
    assert(series_ref01_data_dt0.id === series_ref01_data.id)


    // REMOVE
    const series_ref01_match_rm0: any = { id: series_ref01_data.id }
    await series_ref01_ent.remove(series_ref01_match_rm0)
  

    // LIST
    const series_ref01_match_rt0: any = {}

    const series_ref01_list_rt0 = await series_ref01_ent.list(series_ref01_match_rt0)

    assert(isempty(select(series_ref01_list_rt0, { id: series_ref01_data.id })))


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/series/SeriesTestData.json')

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
    ['series01','series02','series03'],
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
  const idmapEnvVal = process.env['FUNISGO_STREAMING_TEST_SERIES_ENTID']
  const idmapOverridden = null != idmapEnvVal && idmapEnvVal.trim().startsWith('{')

  const env = envOverride({
    'FUNISGO_STREAMING_TEST_SERIES_ENTID': idmap,
    'FUNISGO_STREAMING_TEST_LIVE': 'FALSE',
    'FUNISGO_STREAMING_TEST_EXPLAIN': 'FALSE',
  })

  idmap = env['FUNISGO_STREAMING_TEST_SERIES_ENTID']

  const live = 'TRUE' === env.FUNISGO_STREAMING_TEST_LIVE

  if (live) {
    client = new FunisgoStreamingSDK(merge([
      {
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
  
