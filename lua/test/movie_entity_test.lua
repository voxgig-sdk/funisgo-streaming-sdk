-- Movie entity test

local json = require("dkjson")
local vs = require("utility.struct.struct")
local sdk = require("funisgo-streaming_sdk")
local helpers = require("core.helpers")
local runner = require("test.runner")

local _test_dir = debug.getinfo(1, "S").source:match("^@(.+/)")  or "./"

describe("MovieEntity", function()
  it("should create instance", function()
    local testsdk = sdk.test(nil, nil)
    local ent = testsdk:Movie(nil)
    assert.is_not_nil(ent)
  end)

  -- Feature #4: the entity stream(action, ...) method runs the op pipeline and
  -- returns an iterator over result items. With the streaming feature active it
  -- yields the feature's incremental output; otherwise it falls back to the
  -- materialised list so stream always yields.
  it("should stream", function()
    local seed = {
      entity = {
        ["movie"] = {
          s1 = { id = "s1" },
          s2 = { id = "s2" },
          s3 = { id = "s3" },
        },
      },
    }

    -- Fallback: streaming inactive -> yields the materialised list items.
    local base = sdk.test(seed, nil)
    local seen = {}
    for item in base:Movie(nil):stream("list", nil, nil) do
      table.insert(seen, item)
    end
    assert.are.equal(3, #seen)

    -- Inbound: streaming active -> yields each item from the feature.
    local config = require("config_shared")()
    if type(config.feature) == "table" and config.feature.streaming ~= nil then
      local streamsdk = sdk.test(seed, { feature = { streaming = { active = true } } })
      local got = {}
      for item in streamsdk:Movie(nil):stream("list", nil, nil) do
        if vs.islist(item) then
          for _, sub in ipairs(item) do
            table.insert(got, sub)
          end
        else
          table.insert(got, item)
        end
      end
      assert.are.equal(3, #got)
    end
  end)

  it("should run basic flow", function()
    local setup = movie_basic_setup(nil)
    -- Per-op sdk-test-control.json skip.
    local _live = setup.live or false
    for _, _op in ipairs({"create", "list", "update", "load", "remove"}) do
      local _should_skip, _reason = runner.is_control_skipped("entityOp", "movie." .. _op, _live and "live" or "unit")
      if _should_skip then
        pending(_reason or "skipped via sdk-test-control.json")
        return
      end
    end
    -- The basic flow consumes synthetic IDs from the fixture. In live mode
    -- without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup.synthetic_only then
      pending("live entity test uses synthetic IDs from fixture — set FUNISGO_STREAMING_TEST_MOVIE_ENTID JSON to run live")
      return
    end
    local client = setup.client

    -- CREATE
    local movie_ref01_ent = client:Movie(nil)
    local movie_ref01_data = helpers.to_map(vs.getprop(
      vs.getpath(setup.data, "new.movie"), "movie_ref01"))

    local movie_ref01_data_result, err = movie_ref01_ent:create(movie_ref01_data, nil)
    assert.is_nil(err)
    movie_ref01_data = helpers.to_map(type(movie_ref01_data_result) == 'table' and movie_ref01_data_result.data_get and movie_ref01_data_result:data_get() or movie_ref01_data_result)
    assert.is_not_nil(movie_ref01_data)
    assert.is_not_nil(movie_ref01_data["id"])

    -- LIST
    local movie_ref01_match = {}

    local movie_ref01_list_result, err = movie_ref01_ent:list(movie_ref01_match, nil)
    assert.is_nil(err)
    assert.is_table(movie_ref01_list_result)

    local found_item = vs.select(
      runner.entity_list_to_data(movie_ref01_list_result),
      { id = movie_ref01_data["id"] })
    assert.is_false(vs.isempty(found_item))

    -- UPDATE
    local movie_ref01_data_up0_up = {
      id = movie_ref01_data["id"],
    }

    local movie_ref01_markdef_up0_name = "createdAt"
    local movie_ref01_markdef_up0_value = "Mark01-movie_ref01_" .. tostring(setup.now)
    movie_ref01_data_up0_up[movie_ref01_markdef_up0_name] = movie_ref01_markdef_up0_value

    local movie_ref01_resdata_up0_result, err = movie_ref01_ent:update(movie_ref01_data_up0_up, nil)
    assert.is_nil(err)
    local movie_ref01_resdata_up0 = helpers.to_map(type(movie_ref01_resdata_up0_result) == 'table' and movie_ref01_resdata_up0_result.data_get and movie_ref01_resdata_up0_result:data_get() or movie_ref01_resdata_up0_result)
    assert.is_not_nil(movie_ref01_resdata_up0)
    assert.are.equal(movie_ref01_resdata_up0["id"], movie_ref01_data_up0_up["id"])
    assert.are.equal(movie_ref01_resdata_up0[movie_ref01_markdef_up0_name], movie_ref01_markdef_up0_value)

    -- LOAD
    local movie_ref01_match_dt0 = {
      id = movie_ref01_data["id"],
    }
    local movie_ref01_data_dt0_loaded, err = movie_ref01_ent:load(movie_ref01_match_dt0, nil)
    assert.is_nil(err)
    local movie_ref01_data_dt0_load_result = helpers.to_map(type(movie_ref01_data_dt0_loaded) == 'table' and movie_ref01_data_dt0_loaded.data_get and movie_ref01_data_dt0_loaded:data_get() or movie_ref01_data_dt0_loaded)
    assert.is_not_nil(movie_ref01_data_dt0_load_result)
    assert.are.equal(movie_ref01_data_dt0_load_result["id"], movie_ref01_data["id"])

    -- REMOVE
    local movie_ref01_match_rm0 = {
      id = movie_ref01_data["id"],
    }
    local _, err = movie_ref01_ent:remove(movie_ref01_match_rm0, nil)
    assert.is_nil(err)

    -- LIST
    local movie_ref01_match_rt0 = {}

    local movie_ref01_list_rt0_result, err = movie_ref01_ent:list(movie_ref01_match_rt0, nil)
    assert.is_nil(err)
    assert.is_table(movie_ref01_list_rt0_result)

    local not_found_item = vs.select(
      runner.entity_list_to_data(movie_ref01_list_rt0_result),
      { id = movie_ref01_data["id"] })
    assert.is_true(vs.isempty(not_found_item))

  end)
end)

function movie_basic_setup(extra)
  runner.load_env_local()

  local entity_data_file = _test_dir .. "../../.sdk/test/entity/movie/MovieTestData.json"
  local f = io.open(entity_data_file, "r")
  if f == nil then
    error("failed to read movie test data: " .. entity_data_file)
  end
  local entity_data_source = f:read("*a")
  f:close()

  local entity_data = json.decode(entity_data_source)

  local options = {}
  options["entity"] = entity_data["existing"]

  local client = sdk.test(options, extra)

  -- Generate idmap via transform.
  local idmap = vs.transform(
    { "movie01", "movie02", "movie03" },
    {
      ["`$PACK`"] = { "", {
        ["`$KEY`"] = "`$COPY`",
        ["`$VAL`"] = { "`$FORMAT`", "upper", "`$COPY`" },
      }},
    }
  )

  -- Detect ENTID env override before envOverride consumes it. When live
  -- mode is on without a real override, the basic test runs against synthetic
  -- IDs from the fixture and 4xx's. Surface this so the test can skip.
  local entid_env_raw = os.getenv("FUNISGO_STREAMING_TEST_MOVIE_ENTID")
  local idmap_overridden = entid_env_raw ~= nil and entid_env_raw:match("^%s*{") ~= nil

  local env = runner.env_override({
    ["FUNISGO_STREAMING_TEST_MOVIE_ENTID"] = idmap,
    ["FUNISGO_STREAMING_TEST_LIVE"] = "FALSE",
    ["FUNISGO_STREAMING_TEST_EXPLAIN"] = "FALSE",
    ["FUNISGO_STREAMING_APIKEY"] = "NONE",
  })

  local idmap_resolved = helpers.to_map(
    env["FUNISGO_STREAMING_TEST_MOVIE_ENTID"])
  if idmap_resolved == nil then
    idmap_resolved = helpers.to_map(idmap)
  end

  if env["FUNISGO_STREAMING_TEST_LIVE"] == "TRUE" then
    local merged_opts = vs.merge({
      {
        apikey = env["FUNISGO_STREAMING_APIKEY"],
      },
      extra or {},
    })
    client = sdk.new(helpers.to_map(merged_opts))
  end

  local live = env["FUNISGO_STREAMING_TEST_LIVE"] == "TRUE"
  return {
    client = client,
    data = entity_data,
    idmap = idmap_resolved,
    env = env,
    explain = env["FUNISGO_STREAMING_TEST_EXPLAIN"] == "TRUE",
    live = live,
    synthetic_only = live and not idmap_overridden,
    now = os.time() * 1000,
  }
end
