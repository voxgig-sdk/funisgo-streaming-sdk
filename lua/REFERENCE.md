# FunisgoStreaming Lua SDK Reference

Complete API reference for the FunisgoStreaming Lua SDK.


## FunisgoStreamingSDK

### Constructor

```lua
local sdk = require("funisgo-streaming_sdk")
local client = sdk.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `table` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `table` | Custom headers for all requests. |
| `options.feature` | `table` | Feature configuration. |
| `options.system` | `table` | System overrides (e.g. custom fetch). |


### Static Methods

#### `sdk.test(testopts?, sdkopts?)`

Create a test client with mock features active. Both arguments are optional.

```lua
local client = sdk.test()
```


### Instance Methods

#### `Channel(data)`

Create a new `Channel` entity instance. Pass `nil` for no initial data.

#### `Movie(data)`

Create a new `Movie` entity instance. Pass `nil` for no initial data.

#### `Series(data)`

Create a new `Series` entity instance. Pass `nil` for no initial data.

#### `options_map() -> table`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> table, err`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs.params` | `table` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `table` | Query string parameters. |
| `fetchargs.headers` | `table` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (tables are JSON-serialized). |
| `fetchargs.ctrl` | `table` | Control options (e.g. `{ explain = true }`). |

**Returns:** `table, err`

#### `prepare(fetchargs) -> table, err`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `table, err`


---

## ChannelEntity

```lua
local channel = client:Channel(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `category` | `string` | No |  |
| `createdAt` | `string` | No |  |
| `description` | `string` | No |  |
| `id` | `string` | No |  |
| `isLive` | `boolean` | No |  |
| `isPremium` | `boolean` | No |  |
| `language` | `string` | No |  |
| `logoUrl` | `string` | No |  |
| `name` | `string` | No |  |
| `streamUrl` | `string` | No |  |
| `updatedAt` | `string` | No |  |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `category` | - | - | Yes | Yes | - |
| `createdAt` | - | - | - | - | - |
| `description` | - | - | Yes | Yes | - |
| `id` | - | - | - | - | - |
| `isLive` | - | - | - | - | - |
| `isPremium` | - | - | - | - | - |
| `language` | - | - | - | - | - |
| `logoUrl` | - | - | - | - | - |
| `name` | - | - | Yes | Yes | - |
| `streamUrl` | - | - | - | - | - |
| `updatedAt` | - | - | - | - | - |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Channel():create({
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Channel():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Channel():load({ id = "channel_id" })
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Channel():remove({ id = "channel_id" })
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:Channel():update({
  id = "channel_id",
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ChannelEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## MovieEntity

```lua
local movie = client:Movie(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `createdAt` | `string` | No |  |
| `description` | `string` | No |  |
| `duration` | `number` | No |  |
| `genre` | `table` | No |  |
| `id` | `string` | No |  |
| `isPremium` | `boolean` | No |  |
| `rating` | `number` | No |  |
| `releaseYear` | `number` | No |  |
| `streamUrl` | `string` | No |  |
| `thumbnailUrl` | `string` | No |  |
| `title` | `string` | No |  |
| `updatedAt` | `string` | No |  |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `createdAt` | - | - | - | - | - |
| `description` | - | - | Yes | Yes | - |
| `duration` | - | - | Yes | Yes | - |
| `genre` | - | - | Yes | Yes | - |
| `id` | - | - | - | - | - |
| `isPremium` | - | - | - | - | - |
| `rating` | - | - | - | - | - |
| `releaseYear` | - | - | Yes | Yes | - |
| `streamUrl` | - | - | - | - | - |
| `thumbnailUrl` | - | - | - | - | - |
| `title` | - | - | Yes | Yes | - |
| `updatedAt` | - | - | - | - | - |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Movie():create({
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Movie():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Movie():load({ id = "movie_id" })
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Movie():remove({ id = "movie_id" })
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:Movie():update({
  id = "movie_id",
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MovieEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## SeriesEntity

```lua
local series = client:Series(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `createdAt` | `string` | No |  |
| `description` | `string` | No |  |
| `episodes` | `number` | No |  |
| `genre` | `table` | No |  |
| `id` | `string` | No |  |
| `isPremium` | `boolean` | No |  |
| `rating` | `number` | No |  |
| `releaseYear` | `number` | No |  |
| `seasons` | `number` | No |  |
| `thumbnailUrl` | `string` | No |  |
| `title` | `string` | No |  |
| `updatedAt` | `string` | No |  |

### Field Usage by Operation

| Field | load | list | create | update | remove |
| --- | --- | --- | --- | --- | --- |
| `createdAt` | - | - | - | - | - |
| `description` | - | - | Yes | Yes | - |
| `episodes` | - | - | - | - | - |
| `genre` | - | - | Yes | Yes | - |
| `id` | - | - | - | - | - |
| `isPremium` | - | - | - | - | - |
| `rating` | - | - | - | - | - |
| `releaseYear` | - | - | Yes | Yes | - |
| `seasons` | - | - | - | - | - |
| `thumbnailUrl` | - | - | - | - | - |
| `title` | - | - | Yes | Yes | - |
| `updatedAt` | - | - | - | - | - |

### Operations

#### `create(reqdata, ctrl) -> any, err`

Create a new entity with the given data.

```lua
local result, err = client:Series():create({
})
```

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Series():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Series():load({ id = "series_id" })
```

#### `remove(reqmatch, ctrl) -> any, err`

Remove the entity matching the given criteria.

```lua
local result, err = client:Series():remove({ id = "series_id" })
```

#### `update(reqdata, ctrl) -> any, err`

Update an existing entity. The data must include the entity `id`.

```lua
local result, err = client:Series():update({
  id = "series_id",
  -- Fields to update
})
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SeriesEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```lua
local client = sdk.new({
  feature = {
    test = { active = true },
  },
})
```

