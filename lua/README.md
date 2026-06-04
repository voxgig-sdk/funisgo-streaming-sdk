# FunisgoStreaming Lua SDK

The Lua SDK for the FunisgoStreaming API. Provides an entity-oriented interface using Lua conventions.


## Install
```bash
luarocks install funisgo-streaming-sdk
```

If the module is not yet published, add the source directory to
your `LUA_PATH`:

```bash
export LUA_PATH="path/to/lua/?.lua;path/to/lua/?/init.lua;;"
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```lua
local sdk = require("funisgo-streaming_sdk")

local client = sdk.new({})
```

### 2. List channels

```lua
local result, err = client:Channel(nil):list(nil, nil)
if err then error(err) end

if type(result) == "table" then
  for _, item in ipairs(result) do
    local d = item:data_get()
    print(d["id"], d["name"])
  end
end
```

### 3. Load a channel

```lua
local result, err = client:Channel(nil):load({ id = "example_id" }, nil)
if err then error(err) end
print(result)
```

### 4. Create, update, and remove

```lua
-- Create
local created, _ = client:Channel(nil):create({ name = "Example" }, nil)

-- Update
client:Channel(nil):update({ id = created["id"], name = "Example-Renamed" }, nil)

-- Remove
client:Channel(nil):remove({ id = created["id"] }, nil)
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
if err then error(err) end

if result["ok"] then
  print(result["status"])  -- 200
  print(result["data"])    -- response body
end
```

### Prepare a request without sending it

```lua
local fetchdef, err = client:prepare({
  path = "/api/resource/{id}",
  method = "DELETE",
  params = { id = "example" },
})
if err then error(err) end

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```lua
local client = sdk.test(nil, nil)

local result, err = client:FunisgoStreaming(nil):load(
  { id = "test01" }, nil
)
-- result contains mock response data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```lua
local function mock_fetch(url, init)
  return {
    status = 200,
    statusText = "OK",
    headers = {},
    json = function()
      return { id = "mock01" }
    end,
  }, nil
end

local client = sdk.new({
  base = "http://localhost:8080",
  system = {
    fetch = mock_fetch,
  },
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
FUNISGO-STREAMING_TEST_LIVE=TRUE
```

Then run:

```bash
cd lua && busted test/
```


## Reference

### FunisgoStreamingSDK

```lua
local sdk = require("funisgo-streaming_sdk")
local client = sdk.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `table` | Feature activation flags. |
| `extend` | `table` | Additional Feature instances to load. |
| `system` | `table` | System overrides (e.g. custom `fetch` function). |

### test

```lua
local client = sdk.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### FunisgoStreamingSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> table` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> table, err` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs) -> table, err` | Build and send an HTTP request. |
| `Channel` | `(data) -> ChannelEntity` | Create a Channel entity instance. |
| `Movie` | `(data) -> MovieEntity` | Create a Movie entity instance. |
| `Series` | `(data) -> SeriesEntity` | Create a Series entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any, err` | Load a single entity by match criteria. |
| `list` | `(reqmatch, ctrl) -> any, err` | List entities matching the criteria. |
| `create` | `(reqdata, ctrl) -> any, err` | Create a new entity. |
| `update` | `(reqdata, ctrl) -> any, err` | Update an existing entity. |
| `remove` | `(reqmatch, ctrl) -> any, err` | Remove an entity. |
| `data_get` | `() -> table` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> table` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> string` | Return the entity name. |

### Result shape

Entity operations return `(any, err)`. The first value is a
`table` with these keys:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `boolean` | `true` if the HTTP status is 2xx. |
| `status` | `number` | HTTP status code. |
| `headers` | `table` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

### Entities

#### Channel

| Field | Description |
| --- | --- |
| `category` |  |
| `created_at` |  |
| `data` |  |
| `description` |  |
| `id` |  |
| `is_live` |  |
| `is_premium` |  |
| `language` |  |
| `logo_url` |  |
| `name` |  |
| `stream_url` |  |
| `success` |  |
| `updated_at` |  |

Operations: Create, List, Load, Remove, Update.

API path: `/channels`

#### Movie

| Field | Description |
| --- | --- |
| `created_at` |  |
| `data` |  |
| `description` |  |
| `duration` |  |
| `genre` |  |
| `id` |  |
| `is_premium` |  |
| `rating` |  |
| `release_year` |  |
| `stream_url` |  |
| `success` |  |
| `thumbnail_url` |  |
| `title` |  |
| `updated_at` |  |

Operations: Create, List, Load, Remove, Update.

API path: `/movies`

#### Series

| Field | Description |
| --- | --- |
| `created_at` |  |
| `data` |  |
| `description` |  |
| `episode` |  |
| `genre` |  |
| `id` |  |
| `is_premium` |  |
| `rating` |  |
| `release_year` |  |
| `season` |  |
| `success` |  |
| `thumbnail_url` |  |
| `title` |  |
| `updated_at` |  |

Operations: Create, List, Load, Remove, Update.

API path: `/series`



## Entities


### Channel

Create an instance: `const channel = client.Channel()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `category` | ``$STRING`` |  |
| `created_at` | ``$STRING`` |  |
| `data` | ``$OBJECT`` |  |
| `description` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `is_live` | ``$BOOLEAN`` |  |
| `is_premium` | ``$BOOLEAN`` |  |
| `language` | ``$STRING`` |  |
| `logo_url` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |
| `stream_url` | ``$STRING`` |  |
| `success` | ``$BOOLEAN`` |  |
| `updated_at` | ``$STRING`` |  |

#### Example: Load

```ts
const channel = await client.Channel().load({ id: 'channel_id' })
```

#### Example: List

```ts
const channels = await client.Channel().list()
```

#### Example: Create

```ts
const channel = await client.Channel().create({
  category: /* `$STRING` */,
  description: /* `$STRING` */,
  name: /* `$STRING` */,
})
```


### Movie

Create an instance: `const movie = client.Movie()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | ``$STRING`` |  |
| `data` | ``$OBJECT`` |  |
| `description` | ``$STRING`` |  |
| `duration` | ``$INTEGER`` |  |
| `genre` | ``$ARRAY`` |  |
| `id` | ``$STRING`` |  |
| `is_premium` | ``$BOOLEAN`` |  |
| `rating` | ``$NUMBER`` |  |
| `release_year` | ``$INTEGER`` |  |
| `stream_url` | ``$STRING`` |  |
| `success` | ``$BOOLEAN`` |  |
| `thumbnail_url` | ``$STRING`` |  |
| `title` | ``$STRING`` |  |
| `updated_at` | ``$STRING`` |  |

#### Example: Load

```ts
const movie = await client.Movie().load({ id: 'movie_id' })
```

#### Example: List

```ts
const movies = await client.Movie().list()
```

#### Example: Create

```ts
const movie = await client.Movie().create({
  description: /* `$STRING` */,
  duration: /* `$INTEGER` */,
  genre: /* `$ARRAY` */,
  release_year: /* `$INTEGER` */,
  title: /* `$STRING` */,
})
```


### Series

Create an instance: `const series = client.Series()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |
| `remove(match)` | Remove the matching entity. |
| `update(data)` | Update an existing entity. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `created_at` | ``$STRING`` |  |
| `data` | ``$OBJECT`` |  |
| `description` | ``$STRING`` |  |
| `episode` | ``$INTEGER`` |  |
| `genre` | ``$ARRAY`` |  |
| `id` | ``$STRING`` |  |
| `is_premium` | ``$BOOLEAN`` |  |
| `rating` | ``$NUMBER`` |  |
| `release_year` | ``$INTEGER`` |  |
| `season` | ``$INTEGER`` |  |
| `success` | ``$BOOLEAN`` |  |
| `thumbnail_url` | ``$STRING`` |  |
| `title` | ``$STRING`` |  |
| `updated_at` | ``$STRING`` |  |

#### Example: Load

```ts
const series = await client.Series().load({ id: 'series_id' })
```

#### Example: List

```ts
const seriess = await client.Series().list()
```

#### Example: Create

```ts
const series = await client.Series().create({
  description: /* `$STRING` */,
  genre: /* `$ARRAY` */,
  release_year: /* `$INTEGER` */,
  title: /* `$STRING` */,
})
```


## Explanation

### The operation pipeline

Every entity operation (load, list, create, update, remove) follows a
six-stage pipeline. Each stage fires a feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage returns an error, the pipeline short-circuits and the
error is returned to the caller as a second return value.

### Features and hooks

Features are the extension mechanism. A feature is a Lua table
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as tables

The Lua SDK uses plain Lua tables throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a table.

### Module structure

```
lua/
├── funisgo-streaming_sdk.lua    -- Main SDK module
├── config.lua               -- Configuration
├── features.lua             -- Feature factory
├── core/                    -- Core types and context
├── entity/                  -- Entity implementations
├── feature/                 -- Built-in features (Base, Test, Log)
├── utility/                 -- Utility functions and struct library
└── test/                    -- Test suites
```

The main module (`funisgo-streaming_sdk`) exports the SDK constructor
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```lua
local moon = client:Moon(nil)
moon:load({ planet_id = "earth", id = "luna" }, nil)

-- moon:data_get() now returns the loaded moon data
-- moon:match_get() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
