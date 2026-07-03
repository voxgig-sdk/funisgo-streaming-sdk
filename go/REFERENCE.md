# FunisgoStreaming Golang SDK Reference

Complete API reference for the FunisgoStreaming Golang SDK.


## FunisgoStreamingSDK

### Constructor

```go
func NewFunisgoStreamingSDK(options map[string]any) *FunisgoStreamingSDK
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `map[string]any` | SDK configuration options. |
| `options["apikey"]` | `string` | API key for authentication. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `map[string]any` | Custom headers for all requests. |
| `options["feature"]` | `map[string]any` | Feature configuration. |
| `options["system"]` | `map[string]any` | System overrides (e.g. custom fetch). |


### Static Methods

#### `Test() *FunisgoStreamingSDK`

No-arg convenience constructor for the common no-options test case.

```go
client := sdk.Test()
```

#### `TestSDK(testopts, sdkopts map[string]any) *FunisgoStreamingSDK`

Test client with options. Both arguments may be `nil`.

```go
client := sdk.TestSDK(testopts, sdkopts)
```


### Instance Methods

#### `Channel(data map[string]any) FunisgoStreamingEntity`

Create a new `Channel` entity instance. Pass `nil` for no initial data.

#### `Movie(data map[string]any) FunisgoStreamingEntity`

Create a new `Movie` entity instance. Pass `nil` for no initial data.

#### `Series(data map[string]any) FunisgoStreamingEntity`

Create a new `Series` entity instance. Pass `nil` for no initial data.

#### `OptionsMap() map[string]any`

Return a deep copy of the current SDK options.

#### `GetUtility() *Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs map[string]any) (map[string]any, error)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `map[string]any` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `map[string]any` | Query string parameters. |
| `fetchargs["headers"]` | `map[string]any` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (maps are JSON-serialized). |
| `fetchargs["ctrl"]` | `map[string]any` | Control options (e.g. `map[string]any{"explain": true}`). |

**Returns:** `(map[string]any, error)`

#### `Prepare(fetchargs map[string]any) (map[string]any, error)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `Direct()`.

**Returns:** `(map[string]any, error)`


---

## ChannelEntity

```go
channel := client.Channel(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `category` | ``$STRING`` | Yes |  |
| `created_at` | ``$STRING`` | No |  |
| `data` | ``$OBJECT`` | No |  |
| `description` | ``$STRING`` | Yes |  |
| `id` | ``$STRING`` | No |  |
| `is_live` | ``$BOOLEAN`` | No |  |
| `is_premium` | ``$BOOLEAN`` | No |  |
| `language` | ``$STRING`` | No |  |
| `logo_url` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | Yes |  |
| `stream_url` | ``$STRING`` | No |  |
| `success` | ``$BOOLEAN`` | No |  |
| `updated_at` | ``$STRING`` | No |  |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `category` | - | Yes | - | - | - |
| `created_at` | - | - | - | - | - |
| `data` | - | - | - | - | - |
| `description` | - | Yes | - | - | - |
| `id` | - | - | - | - | - |
| `is_live` | - | - | - | - | - |
| `is_premium` | - | - | - | - | - |
| `language` | - | - | - | - | - |
| `logo_url` | - | - | - | - | - |
| `name` | - | Yes | - | - | - |
| `stream_url` | - | - | - | - | - |
| `success` | - | - | - | - | - |
| `updated_at` | - | - | - | - | - |

### Operations

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Channel(nil).Create(map[string]any{
    "category": /* `$STRING` */,
    "description": /* `$STRING` */,
    "name": /* `$STRING` */,
}, nil)
```

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Channel(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Channel(nil).Load(map[string]any{"id": "channel_id"}, nil)
```

#### `Remove(reqmatch, ctrl map[string]any) (any, error)`

Remove the entity matching the given criteria.

```go
result, err := client.Channel(nil).Remove(map[string]any{"id": "channel_id"}, nil)
```

#### `Update(reqdata, ctrl map[string]any) (any, error)`

Update an existing entity. The data must include the entity `id`.

```go
result, err := client.Channel(nil).Update(map[string]any{
    "id": "channel_id",
    // Fields to update
}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ChannelEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## MovieEntity

```go
movie := client.Movie(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | ``$STRING`` | No |  |
| `data` | ``$OBJECT`` | No |  |
| `description` | ``$STRING`` | Yes |  |
| `duration` | ``$INTEGER`` | Yes |  |
| `genre` | ``$ARRAY`` | Yes |  |
| `id` | ``$STRING`` | No |  |
| `is_premium` | ``$BOOLEAN`` | No |  |
| `rating` | ``$NUMBER`` | No |  |
| `release_year` | ``$INTEGER`` | Yes |  |
| `stream_url` | ``$STRING`` | No |  |
| `success` | ``$BOOLEAN`` | No |  |
| `thumbnail_url` | ``$STRING`` | No |  |
| `title` | ``$STRING`` | Yes |  |
| `updated_at` | ``$STRING`` | No |  |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `created_at` | - | - | - | - | - |
| `data` | - | - | - | - | - |
| `description` | - | Yes | - | - | - |
| `duration` | - | Yes | - | - | - |
| `genre` | - | Yes | - | - | - |
| `id` | - | - | - | - | - |
| `is_premium` | - | - | - | - | - |
| `rating` | - | - | - | - | - |
| `release_year` | - | Yes | - | - | - |
| `stream_url` | - | - | - | - | - |
| `success` | - | - | - | - | - |
| `thumbnail_url` | - | - | - | - | - |
| `title` | - | Yes | - | - | - |
| `updated_at` | - | - | - | - | - |

### Operations

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Movie(nil).Create(map[string]any{
    "description": /* `$STRING` */,
    "duration": /* `$INTEGER` */,
    "genre": /* `$ARRAY` */,
    "release_year": /* `$INTEGER` */,
    "title": /* `$STRING` */,
}, nil)
```

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Movie(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Movie(nil).Load(map[string]any{"id": "movie_id"}, nil)
```

#### `Remove(reqmatch, ctrl map[string]any) (any, error)`

Remove the entity matching the given criteria.

```go
result, err := client.Movie(nil).Remove(map[string]any{"id": "movie_id"}, nil)
```

#### `Update(reqdata, ctrl map[string]any) (any, error)`

Update an existing entity. The data must include the entity `id`.

```go
result, err := client.Movie(nil).Update(map[string]any{
    "id": "movie_id",
    // Fields to update
}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `MovieEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## SeriesEntity

```go
series := client.Series(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | ``$STRING`` | No |  |
| `data` | ``$OBJECT`` | No |  |
| `description` | ``$STRING`` | Yes |  |
| `episode` | ``$INTEGER`` | No |  |
| `genre` | ``$ARRAY`` | Yes |  |
| `id` | ``$STRING`` | No |  |
| `is_premium` | ``$BOOLEAN`` | No |  |
| `rating` | ``$NUMBER`` | No |  |
| `release_year` | ``$INTEGER`` | Yes |  |
| `season` | ``$INTEGER`` | No |  |
| `success` | ``$BOOLEAN`` | No |  |
| `thumbnail_url` | ``$STRING`` | No |  |
| `title` | ``$STRING`` | Yes |  |
| `updated_at` | ``$STRING`` | No |  |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `created_at` | - | - | - | - | - |
| `data` | - | - | - | - | - |
| `description` | - | Yes | - | - | - |
| `episode` | - | - | - | - | - |
| `genre` | - | Yes | - | - | - |
| `id` | - | - | - | - | - |
| `is_premium` | - | - | - | - | - |
| `rating` | - | - | - | - | - |
| `release_year` | - | Yes | - | - | - |
| `season` | - | - | - | - | - |
| `success` | - | - | - | - | - |
| `thumbnail_url` | - | - | - | - | - |
| `title` | - | Yes | - | - | - |
| `updated_at` | - | - | - | - | - |

### Operations

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Series(nil).Create(map[string]any{
    "description": /* `$STRING` */,
    "genre": /* `$ARRAY` */,
    "release_year": /* `$INTEGER` */,
    "title": /* `$STRING` */,
}, nil)
```

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Series(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Series(nil).Load(map[string]any{"id": "series_id"}, nil)
```

#### `Remove(reqmatch, ctrl map[string]any) (any, error)`

Remove the entity matching the given criteria.

```go
result, err := client.Series(nil).Remove(map[string]any{"id": "series_id"}, nil)
```

#### `Update(reqdata, ctrl map[string]any) (any, error)`

Update an existing entity. The data must include the entity `id`.

```go
result, err := client.Series(nil).Update(map[string]any{
    "id": "series_id",
    // Fields to update
}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `SeriesEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```go
client := sdk.NewFunisgoStreamingSDK(map[string]any{
    "feature": map[string]any{
        "test": map[string]any{"active": true},
    },
})
```

