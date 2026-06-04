# Movie entity test

require "minitest/autorun"
require "json"
require_relative "../FunisgoStreaming_sdk"
require_relative "runner"

class MovieEntityTest < Minitest::Test
  def test_create_instance
    testsdk = FunisgoStreamingSDK.test(nil, nil)
    ent = testsdk.Movie(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = movie_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["create", "list", "update", "load", "remove"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "movie." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set FUNISGOSTREAMING_TEST_MOVIE_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # CREATE
    movie_ref01_ent = client.Movie(nil)
    movie_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.movie"), "movie_ref01"))

    movie_ref01_data_result, err = movie_ref01_ent.create(movie_ref01_data, nil)
    assert_nil err
    movie_ref01_data = Helpers.to_map(movie_ref01_data_result)
    assert !movie_ref01_data.nil?
    assert !movie_ref01_data["id"].nil?

    # LIST
    movie_ref01_match = {}

    movie_ref01_list_result, err = movie_ref01_ent.list(movie_ref01_match, nil)
    assert_nil err
    assert movie_ref01_list_result.is_a?(Array)

    found_item = Vs.select(
      Runner.entity_list_to_data(movie_ref01_list_result),
      { "id" => movie_ref01_data["id"] })
    assert !Vs.isempty(found_item)

    # UPDATE
    movie_ref01_data_up0_up = {
      "id" => movie_ref01_data["id"],
    }

    movie_ref01_markdef_up0_name = "created_at"
    movie_ref01_markdef_up0_value = "Mark01-movie_ref01_#{setup[:now]}"
    movie_ref01_data_up0_up[movie_ref01_markdef_up0_name] = movie_ref01_markdef_up0_value

    movie_ref01_resdata_up0_result, err = movie_ref01_ent.update(movie_ref01_data_up0_up, nil)
    assert_nil err
    movie_ref01_resdata_up0 = Helpers.to_map(movie_ref01_resdata_up0_result)
    assert !movie_ref01_resdata_up0.nil?
    assert_equal movie_ref01_resdata_up0["id"], movie_ref01_data_up0_up["id"]
    assert_equal movie_ref01_resdata_up0[movie_ref01_markdef_up0_name], movie_ref01_markdef_up0_value

    # LOAD
    movie_ref01_match_dt0 = {
      "id" => movie_ref01_data["id"],
    }
    movie_ref01_data_dt0_loaded, err = movie_ref01_ent.load(movie_ref01_match_dt0, nil)
    assert_nil err
    movie_ref01_data_dt0_load_result = Helpers.to_map(movie_ref01_data_dt0_loaded)
    assert !movie_ref01_data_dt0_load_result.nil?
    assert_equal movie_ref01_data_dt0_load_result["id"], movie_ref01_data["id"]

    # REMOVE
    movie_ref01_match_rm0 = {
      "id" => movie_ref01_data["id"],
    }
    _, err = movie_ref01_ent.remove(movie_ref01_match_rm0, nil)
    assert_nil err

    # LIST
    movie_ref01_match_rt0 = {}

    movie_ref01_list_rt0_result, err = movie_ref01_ent.list(movie_ref01_match_rt0, nil)
    assert_nil err
    assert movie_ref01_list_rt0_result.is_a?(Array)

    not_found_item = Vs.select(
      Runner.entity_list_to_data(movie_ref01_list_rt0_result),
      { "id" => movie_ref01_data["id"] })
    assert Vs.isempty(not_found_item)

  end
end

def movie_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "movie", "MovieTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = FunisgoStreamingSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["movie01", "movie02", "movie03"],
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
  entid_env_raw = ENV["FUNISGOSTREAMING_TEST_MOVIE_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "FUNISGOSTREAMING_TEST_MOVIE_ENTID" => idmap,
    "FUNISGOSTREAMING_TEST_LIVE" => "FALSE",
    "FUNISGOSTREAMING_TEST_EXPLAIN" => "FALSE",
  })

  idmap_resolved = Helpers.to_map(
    env["FUNISGOSTREAMING_TEST_MOVIE_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["FUNISGOSTREAMING_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
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
