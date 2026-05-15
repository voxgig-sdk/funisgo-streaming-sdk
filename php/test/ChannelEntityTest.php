<?php
declare(strict_types=1);

// Channel entity test

require_once __DIR__ . '/../funisgostreaming_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class ChannelEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = FunisgoStreamingSDK::test(null, null);
        $ent = $testsdk->Channel(null);
        $this->assertNotNull($ent);
    }

    public function test_basic_flow(): void
    {
        $setup = channel_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["create", "list", "update", "load", "remove"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "channel." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set FUNISGOSTREAMING_TEST_CHANNEL_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // CREATE
        $channel_ref01_ent = $client->Channel(null);
        $channel_ref01_data = Helpers::to_map(Vs::getprop(
            Vs::getpath($setup["data"], "new.channel"), "channel_ref01"));

        [$channel_ref01_data_result, $err] = $channel_ref01_ent->create($channel_ref01_data, null);
        $this->assertNull($err);
        $channel_ref01_data = Helpers::to_map($channel_ref01_data_result);
        $this->assertNotNull($channel_ref01_data);
        $this->assertNotNull($channel_ref01_data["id"]);

        // LIST
        $channel_ref01_match = [];

        [$channel_ref01_list_result, $err] = $channel_ref01_ent->list($channel_ref01_match, null);
        $this->assertNull($err);
        $this->assertIsArray($channel_ref01_list_result);

        $found_item = sdk_select(
            Runner::entity_list_to_data($channel_ref01_list_result),
            ["id" => $channel_ref01_data["id"]]);
        $this->assertNotEmpty($found_item);

        // UPDATE
        $channel_ref01_data_up0_up = [
            "id" => $channel_ref01_data["id"],
        ];

        $channel_ref01_markdef_up0_name = "category";
        $channel_ref01_markdef_up0_value = "Mark01-channel_ref01_" . $setup["now"];
        $channel_ref01_data_up0_up[$channel_ref01_markdef_up0_name] = $channel_ref01_markdef_up0_value;

        [$channel_ref01_resdata_up0_result, $err] = $channel_ref01_ent->update($channel_ref01_data_up0_up, null);
        $this->assertNull($err);
        $channel_ref01_resdata_up0 = Helpers::to_map($channel_ref01_resdata_up0_result);
        $this->assertNotNull($channel_ref01_resdata_up0);
        $this->assertEquals($channel_ref01_resdata_up0["id"], $channel_ref01_data_up0_up["id"]);
        $this->assertEquals($channel_ref01_resdata_up0[$channel_ref01_markdef_up0_name], $channel_ref01_markdef_up0_value);

        // LOAD
        $channel_ref01_match_dt0 = [
            "id" => $channel_ref01_data["id"],
        ];
        [$channel_ref01_data_dt0_loaded, $err] = $channel_ref01_ent->load($channel_ref01_match_dt0, null);
        $this->assertNull($err);
        $channel_ref01_data_dt0_load_result = Helpers::to_map($channel_ref01_data_dt0_loaded);
        $this->assertNotNull($channel_ref01_data_dt0_load_result);
        $this->assertEquals($channel_ref01_data_dt0_load_result["id"], $channel_ref01_data["id"]);

        // REMOVE
        $channel_ref01_match_rm0 = [
            "id" => $channel_ref01_data["id"],
        ];
        [$_, $err] = $channel_ref01_ent->remove($channel_ref01_match_rm0, null);
        $this->assertNull($err);

        // LIST
        $channel_ref01_match_rt0 = [];

        [$channel_ref01_list_rt0_result, $err] = $channel_ref01_ent->list($channel_ref01_match_rt0, null);
        $this->assertNull($err);
        $this->assertIsArray($channel_ref01_list_rt0_result);

        $not_found_item = sdk_select(
            Runner::entity_list_to_data($channel_ref01_list_rt0_result),
            ["id" => $channel_ref01_data["id"]]);
        $this->assertEmpty($not_found_item);

    }
}

function channel_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/channel/ChannelTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = FunisgoStreamingSDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["channel01", "channel02", "channel03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("FUNISGOSTREAMING_TEST_CHANNEL_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "FUNISGOSTREAMING_TEST_CHANNEL_ENTID" => $idmap,
        "FUNISGOSTREAMING_TEST_LIVE" => "FALSE",
        "FUNISGOSTREAMING_TEST_EXPLAIN" => "FALSE",
        "FUNISGOSTREAMING_APIKEY" => "NONE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["FUNISGOSTREAMING_TEST_CHANNEL_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["FUNISGOSTREAMING_TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
                "apikey" => $env["FUNISGOSTREAMING_APIKEY"],
            ],
            $extra ?? [],
        ]);
        $client = new FunisgoStreamingSDK(Helpers::to_map($merged_opts));
    }

    $live = $env["FUNISGOSTREAMING_TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["FUNISGOSTREAMING_TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}
