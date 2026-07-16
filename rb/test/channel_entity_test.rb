# Channel entity test

require "minitest/autorun"
require "json"
require_relative "../FunisgoStreaming_sdk"
require_relative "runner"

class ChannelEntityTest < Minitest::Test
  def test_create_instance
    testsdk = FunisgoStreamingSDK.test(nil, nil)
    ent = testsdk.Channel(nil)
    assert !ent.nil?
  end

  # Feature #4: the entity stream(action, ...) method runs the op pipeline and
  # returns an Enumerator over result items. With the streaming feature active
  # it yields the feature's incremental output; otherwise it falls back to the
  # materialised list so stream always yields.
  def test_stream
    seed = {
      "entity" => {
        "channel" => {
          "s1" => { "id" => "s1" },
          "s2" => { "id" => "s2" },
          "s3" => { "id" => "s3" },
        },
      },
    }

    # Fallback: streaming inactive -> yields the materialised list items.
    base = FunisgoStreamingSDK.test(seed, nil)
    seen = base.Channel(nil).stream("list", nil, nil).to_a
    assert_equal 3, seen.length

    # Inbound: streaming active -> yields each item from the feature.
    cfg = FunisgoStreamingConfig.make_config
    if cfg["feature"].is_a?(Hash) && cfg["feature"].key?("streaming")
      sdk = FunisgoStreamingSDK.test(seed, { "feature" => { "streaming" => { "active" => true } } })
      got = []
      sdk.Channel(nil).stream("list", nil, nil).each do |item|
        if item.is_a?(Array)
          got.concat(item)
        else
          got << item
        end
      end
      assert_equal 3, got.length
    end
  end

  def test_basic_flow
    setup = channel_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["create", "list", "update", "load", "remove"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "channel." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set FUNISGOSTREAMING_TEST_CHANNEL_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # CREATE
    channel_ref01_ent = client.Channel(nil)
    channel_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.channel"), "channel_ref01"))

    channel_ref01_data_result = channel_ref01_ent.create(channel_ref01_data, nil)
    channel_ref01_data = Helpers.to_map(channel_ref01_data_result)
    assert !channel_ref01_data.nil?
    assert !channel_ref01_data["id"].nil?

    # LIST
    channel_ref01_match = {}

    channel_ref01_list_result = channel_ref01_ent.list(channel_ref01_match, nil)
    assert channel_ref01_list_result.is_a?(Array)

    found_item = Vs.select(
      Runner.entity_list_to_data(channel_ref01_list_result),
      { "id" => channel_ref01_data["id"] })
    assert !Vs.isempty(found_item)

    # UPDATE
    channel_ref01_data_up0_up = {
      "id" => channel_ref01_data["id"],
    }

    channel_ref01_markdef_up0_name = "category"
    channel_ref01_markdef_up0_value = "Mark01-channel_ref01_#{setup[:now]}"
    channel_ref01_data_up0_up[channel_ref01_markdef_up0_name] = channel_ref01_markdef_up0_value

    channel_ref01_resdata_up0_result = channel_ref01_ent.update(channel_ref01_data_up0_up, nil)
    channel_ref01_resdata_up0 = Helpers.to_map(channel_ref01_resdata_up0_result)
    assert !channel_ref01_resdata_up0.nil?
    assert_equal channel_ref01_resdata_up0["id"], channel_ref01_data_up0_up["id"]
    assert_equal channel_ref01_resdata_up0[channel_ref01_markdef_up0_name], channel_ref01_markdef_up0_value

    # LOAD
    channel_ref01_match_dt0 = {
      "id" => channel_ref01_data["id"],
    }
    channel_ref01_data_dt0_loaded = channel_ref01_ent.load(channel_ref01_match_dt0, nil)
    channel_ref01_data_dt0_load_result = Helpers.to_map(channel_ref01_data_dt0_loaded)
    assert !channel_ref01_data_dt0_load_result.nil?
    assert_equal channel_ref01_data_dt0_load_result["id"], channel_ref01_data["id"]

    # REMOVE
    channel_ref01_match_rm0 = {
      "id" => channel_ref01_data["id"],
    }
    channel_ref01_ent.remove(channel_ref01_match_rm0, nil)

    # LIST
    channel_ref01_match_rt0 = {}

    channel_ref01_list_rt0_result = channel_ref01_ent.list(channel_ref01_match_rt0, nil)
    assert channel_ref01_list_rt0_result.is_a?(Array)

    not_found_item = Vs.select(
      Runner.entity_list_to_data(channel_ref01_list_rt0_result),
      { "id" => channel_ref01_data["id"] })
    assert Vs.isempty(not_found_item)

  end
end

def channel_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "channel", "ChannelTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = FunisgoStreamingSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["channel01", "channel02", "channel03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["FUNISGOSTREAMING_TEST_CHANNEL_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "FUNISGOSTREAMING_TEST_CHANNEL_ENTID" => idmap,
    "FUNISGOSTREAMING_TEST_LIVE" => "FALSE",
    "FUNISGOSTREAMING_TEST_EXPLAIN" => "FALSE",
    "FUNISGOSTREAMING_APIKEY" => "NONE",
  })

  idmap_resolved = Helpers.to_map(
    env["FUNISGOSTREAMING_TEST_CHANNEL_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["FUNISGOSTREAMING_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
        "apikey" => env["FUNISGOSTREAMING_APIKEY"],
      },
      extra || {},
    ])
    client = FunisgoStreamingSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["FUNISGOSTREAMING_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["FUNISGOSTREAMING_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
