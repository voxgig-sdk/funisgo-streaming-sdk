# FunisgoStreaming Ruby SDK Reference

Complete API reference for the FunisgoStreaming Ruby SDK.


## FunisgoStreamingSDK

### Constructor

```ruby
require_relative 'FunisgoStreaming_sdk'

client = FunisgoStreamingSDK.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Hash` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Hash` | Custom headers for all requests. |
| `options["feature"]` | `Hash` | Feature configuration. |
| `options["system"]` | `Hash` | System overrides (e.g. custom fetch). |


### Static Methods

#### `FunisgoStreamingSDK.test(testopts = nil, sdkopts = nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```ruby
client = FunisgoStreamingSDK.test
```


### Instance Methods

#### `Channel(data = nil)`

Create a new `Channel` entity instance. Pass `nil` for no initial data.

#### `Movie(data = nil)`

Create a new `Movie` entity instance. Pass `nil` for no initial data.

#### `Series(data = nil)`

Create a new `Series` entity instance. Pass `nil` for no initial data.

#### `options_map -> Hash`

Return a deep copy of the current SDK options.

#### `get_utility -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs = {}) -> Hash`

Make a direct HTTP request to any API endpoint. Returns a result hash
(`{ "ok" => ..., "status" => ..., "data" => ..., "err" => ... }`); it
does not raise — inspect `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Hash` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `Hash` | Query string parameters. |
| `fetchargs["headers"]` | `Hash` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (hashes are JSON-serialized). |
| `fetchargs["ctrl"]` | `Hash` | Control options (e.g. `{ "explain" => true }`). |

**Returns:** `Hash`

#### `prepare(fetchargs = {}) -> Hash`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`. Raises on error.

**Returns:** `Hash` (the fetch definition; raises on error)


---

## ChannelEntity

```ruby
channel = client.Channel
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `category` | `String` | Yes |  |
| `created_at` | `String` | No |  |
| `data` | `Hash` | No |  |
| `description` | `String` | Yes |  |
| `id` | `String` | No |  |
| `is_live` | `Boolean` | No |  |
| `is_premium` | `Boolean` | No |  |
| `language` | `String` | No |  |
| `logo_url` | `String` | No |  |
| `name` | `String` | Yes |  |
| `stream_url` | `String` | No |  |
| `success` | `Boolean` | No |  |
| `updated_at` | `String` | No |  |

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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Channel.create({
  "category" => "example", # String
  "description" => "example", # String
  "name" => "example", # String
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Channel.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Channel.load({ "id" => "channel_id" })
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Channel.remove({ "id" => "channel_id" })
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.Channel.update({
  "id" => "channel_id",
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ChannelEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## MovieEntity

```ruby
movie = client.Movie
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `String` | No |  |
| `data` | `Hash` | No |  |
| `description` | `String` | Yes |  |
| `duration` | `Integer` | Yes |  |
| `genre` | `Array` | Yes |  |
| `id` | `String` | No |  |
| `is_premium` | `Boolean` | No |  |
| `rating` | `Float` | No |  |
| `release_year` | `Integer` | Yes |  |
| `stream_url` | `String` | No |  |
| `success` | `Boolean` | No |  |
| `thumbnail_url` | `String` | No |  |
| `title` | `String` | Yes |  |
| `updated_at` | `String` | No |  |

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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Movie.create({
  "description" => "example", # String
  "duration" => 1, # Integer
  "genre" => [], # Array
  "release_year" => 1, # Integer
  "title" => "example", # String
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Movie.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Movie.load({ "id" => "movie_id" })
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Movie.remove({ "id" => "movie_id" })
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.Movie.update({
  "id" => "movie_id",
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `MovieEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SeriesEntity

```ruby
series = client.Series
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `created_at` | `String` | No |  |
| `data` | `Hash` | No |  |
| `description` | `String` | Yes |  |
| `episode` | `Integer` | No |  |
| `genre` | `Array` | Yes |  |
| `id` | `String` | No |  |
| `is_premium` | `Boolean` | No |  |
| `rating` | `Float` | No |  |
| `release_year` | `Integer` | Yes |  |
| `season` | `Integer` | No |  |
| `success` | `Boolean` | No |  |
| `thumbnail_url` | `String` | No |  |
| `title` | `String` | Yes |  |
| `updated_at` | `String` | No |  |

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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Series.create({
  "description" => "example", # String
  "genre" => [], # Array
  "release_year" => 1, # Integer
  "title" => "example", # String
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Series.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Series.load({ "id" => "series_id" })
```

#### `remove(reqmatch, ctrl = nil) -> result`

Remove the entity matching the given criteria. Raises on error.

```ruby
result = client.Series.remove({ "id" => "series_id" })
```

#### `update(reqdata, ctrl = nil) -> result`

Update an existing entity. The data must include the entity `id`. Raises on error.

```ruby
result = client.Series.update({
  "id" => "series_id",
  # Fields to update
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SeriesEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ruby
client = FunisgoStreamingSDK.new({
  "feature" => {
    "test" => { "active" => true },
  },
})
```

