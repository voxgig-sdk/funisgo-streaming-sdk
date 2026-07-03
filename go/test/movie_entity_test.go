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

func TestMovieEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Movie(nil)
		if ent == nil {
			t.Fatal("expected non-nil MovieEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := movieBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create", "list", "update", "load", "remove"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "movie." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set FUNISGOSTREAMING_TEST_MOVIE_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		movieRef01Ent := client.Movie(nil)
		movieRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "movie"}, setup.data), "movie_ref01"))

		movieRef01DataResult, err := movieRef01Ent.Create(movieRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		movieRef01Data = core.ToMapAny(movieRef01DataResult)
		if movieRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}
		if movieRef01Data["id"] == nil {
			t.Fatal("expected created entity to have an id")
		}

		// LIST
		movieRef01Match := map[string]any{}

		movieRef01ListResult, err := movieRef01Ent.List(movieRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		movieRef01List, movieRef01ListOk := movieRef01ListResult.([]any)
		if !movieRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", movieRef01ListResult)
		}

		foundItem := vs.Select(entityListToData(movieRef01List), map[string]any{"id": movieRef01Data["id"]})
		if vs.IsEmpty(foundItem) {
			t.Fatal("expected to find created entity in list")
		}

		// UPDATE
		movieRef01DataUp0Up := map[string]any{
			"id": movieRef01Data["id"],
		}

		movieRef01MarkdefUp0Name := "created_at"
		movieRef01MarkdefUp0Value := fmt.Sprintf("Mark01-movie_ref01_%d", setup.now)
		movieRef01DataUp0Up[movieRef01MarkdefUp0Name] = movieRef01MarkdefUp0Value

		movieRef01ResdataUp0Result, err := movieRef01Ent.Update(movieRef01DataUp0Up, nil)
		if err != nil {
			t.Fatalf("update failed: %v", err)
		}
		movieRef01ResdataUp0 := core.ToMapAny(movieRef01ResdataUp0Result)
		if movieRef01ResdataUp0 == nil {
			t.Fatal("expected update result to be a map")
		}
		if movieRef01ResdataUp0["id"] != movieRef01DataUp0Up["id"] {
			t.Fatal("expected update result id to match")
		}
		if movieRef01ResdataUp0[movieRef01MarkdefUp0Name] != movieRef01MarkdefUp0Value {
			t.Fatalf("expected %s to be updated, got %v", movieRef01MarkdefUp0Name, movieRef01ResdataUp0[movieRef01MarkdefUp0Name])
		}

		// LOAD
		movieRef01MatchDt0 := map[string]any{
			"id": movieRef01Data["id"],
		}
		movieRef01DataDt0Loaded, err := movieRef01Ent.Load(movieRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		movieRef01DataDt0LoadResult := core.ToMapAny(movieRef01DataDt0Loaded)
		if movieRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if movieRef01DataDt0LoadResult["id"] != movieRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

		// REMOVE
		movieRef01MatchRm0 := map[string]any{
			"id": movieRef01Data["id"],
		}
		_, err = movieRef01Ent.Remove(movieRef01MatchRm0, nil)
		if err != nil {
			t.Fatalf("remove failed: %v", err)
		}

		// LIST
		movieRef01MatchRt0 := map[string]any{}

		movieRef01ListRt0Result, err := movieRef01Ent.List(movieRef01MatchRt0, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		movieRef01ListRt0, movieRef01ListRt0Ok := movieRef01ListRt0Result.([]any)
		if !movieRef01ListRt0Ok {
			t.Fatalf("expected list result to be an array, got %T", movieRef01ListRt0Result)
		}

		notFoundItem := vs.Select(entityListToData(movieRef01ListRt0), map[string]any{"id": movieRef01Data["id"]})
		if !vs.IsEmpty(notFoundItem) {
			t.Fatal("expected removed entity to not be in list")
		}

	})
}

func movieBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "movie", "MovieTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read movie test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse movie test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"movie01", "movie02", "movie03"},
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
	entidEnvRaw := os.Getenv("FUNISGOSTREAMING_TEST_MOVIE_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"FUNISGOSTREAMING_TEST_MOVIE_ENTID": idmap,
		"FUNISGOSTREAMING_TEST_LIVE":      "FALSE",
		"FUNISGOSTREAMING_TEST_EXPLAIN":   "FALSE",
		"FUNISGOSTREAMING_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["FUNISGOSTREAMING_TEST_MOVIE_ENTID"])
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
