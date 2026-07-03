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

func TestSeriesEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Series(nil)
		if ent == nil {
			t.Fatal("expected non-nil SeriesEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := seriesBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list", "update", "load", "remove"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "series." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set FUNISGOSTREAMING_TEST_SERIES_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		seriesRef01Ent := client.Series(nil)
		seriesRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "series"}, setup.data), "series_ref01"))

		seriesRef01DataResult, err := seriesRef01Ent.Create(seriesRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		seriesRef01Data = core.ToMapAny(seriesRef01DataResult)
		if seriesRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}
		if seriesRef01Data["id"] == nil {
			t.Fatal("expected created entity to have an id")
		}

		// LIST
		seriesRef01Match := map[string]any{}

		seriesRef01ListResult, err := seriesRef01Ent.List(seriesRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		seriesRef01List, seriesRef01ListOk := seriesRef01ListResult.([]any)
		if !seriesRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", seriesRef01ListResult)
		}

		foundItem := vs.Select(entityListToData(seriesRef01List), map[string]any{"id": seriesRef01Data["id"]})
		if vs.IsEmpty(foundItem) {
			t.Fatal("expected to find created entity in list")
		}

		// UPDATE
		seriesRef01DataUp0Up := map[string]any{
			"id": seriesRef01Data["id"],
		}

		seriesRef01MarkdefUp0Name := "created_at"
		seriesRef01MarkdefUp0Value := fmt.Sprintf("Mark01-series_ref01_%d", setup.now)
		seriesRef01DataUp0Up[seriesRef01MarkdefUp0Name] = seriesRef01MarkdefUp0Value

		seriesRef01ResdataUp0Result, err := seriesRef01Ent.Update(seriesRef01DataUp0Up, nil)
		if err != nil {
			t.Fatalf("update failed: %v", err)
		}
		seriesRef01ResdataUp0 := core.ToMapAny(seriesRef01ResdataUp0Result)
		if seriesRef01ResdataUp0 == nil {
			t.Fatal("expected update result to be a map")
		}
		if seriesRef01ResdataUp0["id"] != seriesRef01DataUp0Up["id"] {
			t.Fatal("expected update result id to match")
		}
		if seriesRef01ResdataUp0[seriesRef01MarkdefUp0Name] != seriesRef01MarkdefUp0Value {
			t.Fatalf("expected %s to be updated, got %v", seriesRef01MarkdefUp0Name, seriesRef01ResdataUp0[seriesRef01MarkdefUp0Name])
		}

		// LOAD
		seriesRef01MatchDt0 := map[string]any{
			"id": seriesRef01Data["id"],
		}
		seriesRef01DataDt0Loaded, err := seriesRef01Ent.Load(seriesRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		seriesRef01DataDt0LoadResult := core.ToMapAny(seriesRef01DataDt0Loaded)
		if seriesRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if seriesRef01DataDt0LoadResult["id"] != seriesRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

		// REMOVE
		seriesRef01MatchRm0 := map[string]any{
			"id": seriesRef01Data["id"],
		}
		_, err = seriesRef01Ent.Remove(seriesRef01MatchRm0, nil)
		if err != nil {
			t.Fatalf("remove failed: %v", err)
		}

		// LIST
		seriesRef01MatchRt0 := map[string]any{}

		seriesRef01ListRt0Result, err := seriesRef01Ent.List(seriesRef01MatchRt0, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		seriesRef01ListRt0, seriesRef01ListRt0Ok := seriesRef01ListRt0Result.([]any)
		if !seriesRef01ListRt0Ok {
			t.Fatalf("expected list result to be an array, got %T", seriesRef01ListRt0Result)
		}

		notFoundItem := vs.Select(entityListToData(seriesRef01ListRt0), map[string]any{"id": seriesRef01Data["id"]})
		if !vs.IsEmpty(notFoundItem) {
			t.Fatal("expected removed entity to not be in list")
		}

	})
}

func seriesBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "series", "SeriesTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read series test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse series test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"series01", "series02", "series03"},
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
	entidEnvRaw := os.Getenv("FUNISGOSTREAMING_TEST_SERIES_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"FUNISGOSTREAMING_TEST_SERIES_ENTID": idmap,
		"FUNISGOSTREAMING_TEST_LIVE":      "FALSE",
		"FUNISGOSTREAMING_TEST_EXPLAIN":   "FALSE",
		"FUNISGOSTREAMING_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["FUNISGOSTREAMING_TEST_SERIES_ENTID"])
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
