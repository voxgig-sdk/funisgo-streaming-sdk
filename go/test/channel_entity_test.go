package sdktest

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/funisgo-streaming-sdk/go"
	"github.com/voxgig-sdk/funisgo-streaming-sdk/go/core"

	vs "github.com/voxgig-sdk/funisgo-streaming-sdk/go/utility/struct"
)

func TestChannelEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Channel(nil)
		if ent == nil {
			t.Fatal("expected non-nil ChannelEntity")
		}
	})

	// Feature #4: the entity Stream(action, ...) method runs the op pipeline and
	// returns a channel over result items. With the streaming feature active it
	// yields the feature's incremental output; otherwise it falls back to the
	// materialised list so Stream always yields.
	t.Run("stream", func(t *testing.T) {
		seed := map[string]any{
			"entity": map[string]any{
				"channel": map[string]any{
					"s1": map[string]any{"id": "s1"},
					"s2": map[string]any{"id": "s2"},
					"s3": map[string]any{"id": "s3"},
				},
			},
		}

		// Fallback: streaming inactive -> yields the materialised list items.
		base := sdk.TestSDK(seed, nil)
		var seen []any
		for item := range base.Channel(nil).Stream("list", nil, nil) {
			seen = append(seen, item)
		}
		if len(seen) != 3 {
			t.Fatalf("expected 3 streamed items, got %d", len(seen))
		}

		// Inbound: streaming active -> yields each item from the feature iterator.
		hasStreaming := false
		if fm, ok := core.MakeConfig()["feature"].(map[string]any); ok {
			_, hasStreaming = fm["streaming"]
		}
		if hasStreaming {
			streamSdk := sdk.TestSDK(seed, map[string]any{
				"feature": map[string]any{"streaming": map[string]any{"active": true}},
			})
			var got []any
			for item := range streamSdk.Channel(nil).Stream("list", nil, nil) {
				if sub, ok := item.([]any); ok {
					got = append(got, sub...)
				} else {
					got = append(got, item)
				}
			}
			if len(got) != 3 {
				t.Fatalf("expected 3 items via streaming feature, got %d", len(got))
			}
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := channelBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list", "update", "load", "remove"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "channel." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set FUNISGOSTREAMING_TEST_CHANNEL_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		channelRef01Ent := client.Channel(nil)
		channelRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "channel"}, setup.data), "channel_ref01"))

		channelRef01DataResult, err := channelRef01Ent.Create(channelRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		channelRef01Data = core.ToMapAny(channelRef01DataResult)
		if channelRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}
		if channelRef01Data["id"] == nil {
			t.Fatal("expected created entity to have an id")
		}

		// LIST
		channelRef01Match := map[string]any{}

		channelRef01ListResult, err := channelRef01Ent.List(channelRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		channelRef01List, channelRef01ListOk := channelRef01ListResult.([]any)
		if !channelRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", channelRef01ListResult)
		}

		foundItem := vs.Select(entityListToData(channelRef01List), map[string]any{"id": channelRef01Data["id"]})
		if vs.IsEmpty(foundItem) {
			t.Fatal("expected to find created entity in list")
		}

		// UPDATE
		channelRef01DataUp0Up := map[string]any{
			"id": channelRef01Data["id"],
		}

		channelRef01MarkdefUp0Name := "category"
		channelRef01MarkdefUp0Value := fmt.Sprintf("Mark01-channel_ref01_%d", setup.now)
		channelRef01DataUp0Up[channelRef01MarkdefUp0Name] = channelRef01MarkdefUp0Value

		channelRef01ResdataUp0Result, err := channelRef01Ent.Update(channelRef01DataUp0Up, nil)
		if err != nil {
			t.Fatalf("update failed: %v", err)
		}
		channelRef01ResdataUp0 := core.ToMapAny(channelRef01ResdataUp0Result)
		if channelRef01ResdataUp0 == nil {
			t.Fatal("expected update result to be a map")
		}
		if channelRef01ResdataUp0["id"] != channelRef01DataUp0Up["id"] {
			t.Fatal("expected update result id to match")
		}
		if channelRef01ResdataUp0[channelRef01MarkdefUp0Name] != channelRef01MarkdefUp0Value {
			t.Fatalf("expected %s to be updated, got %v", channelRef01MarkdefUp0Name, channelRef01ResdataUp0[channelRef01MarkdefUp0Name])
		}

		// LOAD
		channelRef01MatchDt0 := map[string]any{
			"id": channelRef01Data["id"],
		}
		channelRef01DataDt0Loaded, err := channelRef01Ent.Load(channelRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		channelRef01DataDt0LoadResult := core.ToMapAny(channelRef01DataDt0Loaded)
		if channelRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if channelRef01DataDt0LoadResult["id"] != channelRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

		// REMOVE
		channelRef01MatchRm0 := map[string]any{
			"id": channelRef01Data["id"],
		}
		_, err = channelRef01Ent.Remove(channelRef01MatchRm0, nil)
		if err != nil {
			t.Fatalf("remove failed: %v", err)
		}

		// LIST
		channelRef01MatchRt0 := map[string]any{}

		channelRef01ListRt0Result, err := channelRef01Ent.List(channelRef01MatchRt0, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		channelRef01ListRt0, channelRef01ListRt0Ok := channelRef01ListRt0Result.([]any)
		if !channelRef01ListRt0Ok {
			t.Fatalf("expected list result to be an array, got %T", channelRef01ListRt0Result)
		}

		notFoundItem := vs.Select(entityListToData(channelRef01ListRt0), map[string]any{"id": channelRef01Data["id"]})
		if !vs.IsEmpty(notFoundItem) {
			t.Fatal("expected removed entity to not be in list")
		}

	})
}

func channelBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "channel", "ChannelTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read channel test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse channel test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"channel01", "channel02", "channel03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("FUNISGOSTREAMING_TEST_CHANNEL_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"FUNISGOSTREAMING_TEST_CHANNEL_ENTID": idmap,
		"FUNISGOSTREAMING_TEST_LIVE":      "FALSE",
		"FUNISGOSTREAMING_TEST_EXPLAIN":   "FALSE",
		"FUNISGOSTREAMING_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["FUNISGOSTREAMING_TEST_CHANNEL_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["FUNISGOSTREAMING_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["FUNISGOSTREAMING_APIKEY"],
			},
			extra,
		})
		client = sdk.NewFunisgoStreamingSDK(core.ToMapAny(mergedOpts))
	}

	live := env["FUNISGOSTREAMING_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["FUNISGOSTREAMING_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
