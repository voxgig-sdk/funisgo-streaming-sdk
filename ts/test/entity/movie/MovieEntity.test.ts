
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


describe('MovieEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when FUNISGO_STREAMING_TEST_LIVE=TRUE.
  afterEach(liveDelay('FUNISGO_STREAMING_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = FunisgoStreamingSDK.test()
    const ent = testsdk.Movie()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.FUNISGO_STREAMING_TEST_LIVE
    for (const op of ['create', 'list', 'update', 'load', 'remove']) {
      if (maybeSkipControl(t, 'entityOp', 'movie.' + op, live)) return
    }

    const setup = basicSetup()
    // The basic flow consumes synthetic IDs and field values from the
    // fixture (entity TestData.json). Those don't exist on the live API.
    // Skip live runs unless the user provided a real ENTID env override.
    if (setup.syntheticOnly) {
      t.skip('live entity test uses synthetic IDs from fixture — set FUNISGO_STREAMING_TEST_MOVIE_ENTID JSON to run live')
      return
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const movie_ref01_ent = client.Movie()
    let movie_ref01_data = setup.data.new.movie['movie_ref01']

    movie_ref01_data = (await movie_ref01_ent.create(movie_ref01_data)).data()
    assert(null != movie_ref01_data.id)


    // LIST
    const movie_ref01_match: any = {}

    const movie_ref01_list = (await movie_ref01_ent.list(movie_ref01_match)).map((e: any) => e.data())

    assert(!isempty(select(movie_ref01_list, { id: movie_ref01_data.id })))


    // UPDATE
    const movie_ref01_data_up0: any = {}
    movie_ref01_data_up0.id = movie_ref01_data.id

    const movie_ref01_markdef_up0 = { name: 'createdAt', value: 'Mark01-movie_ref01_' + setup.now }
    ;(movie_ref01_data_up0 as any)[movie_ref01_markdef_up0.name] = movie_ref01_markdef_up0.value

    const movie_ref01_resdata_up0 = (await movie_ref01_ent.update(movie_ref01_data_up0)).data()
    assert(movie_ref01_resdata_up0.id === movie_ref01_data_up0.id)

    assert((movie_ref01_resdata_up0 as any)[movie_ref01_markdef_up0.name] === movie_ref01_markdef_up0.value)


    // LOAD
    const movie_ref01_match_dt0: any = {}
    movie_ref01_match_dt0.id = movie_ref01_data.id
    const movie_ref01_data_dt0 = (await movie_ref01_ent.load(movie_ref01_match_dt0)).data()
    assert(movie_ref01_data_dt0.id === movie_ref01_data.id)


    // REMOVE
    const movie_ref01_match_rm0: any = { id: movie_ref01_data.id }
    await movie_ref01_ent.remove(movie_ref01_match_rm0)
  

    // LIST
    const movie_ref01_match_rt0: any = {}

    const movie_ref01_list_rt0 = (await movie_ref01_ent.list(movie_ref01_match_rt0)).map((e: any) => e.data())

    assert(isempty(select(movie_ref01_list_rt0, { id: movie_ref01_data.id })))


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/movie/MovieTestData.json')

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
    ['movie01','movie02','movie03'],
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
  const idmapEnvVal = process.env['FUNISGO_STREAMING_TEST_MOVIE_ENTID']
  const idmapOverridden = null != idmapEnvVal && idmapEnvVal.trim().startsWith('{')

  const env = envOverride({
    'FUNISGO_STREAMING_TEST_MOVIE_ENTID': idmap,
    'FUNISGO_STREAMING_TEST_LIVE': 'FALSE',
    'FUNISGO_STREAMING_TEST_EXPLAIN': 'FALSE',
    'FUNISGO_STREAMING_APIKEY': 'NONE',
  })

  idmap = env['FUNISGO_STREAMING_TEST_MOVIE_ENTID']

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
  
