# FunisgoStreaming Python SDK Reference

Complete API reference for the FunisgoStreaming Python SDK.


## FunisgoStreamingSDK

### Constructor

```python
from funisgostreaming_sdk import FunisgoStreamingSDK

client = FunisgoStreamingSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `FunisgoStreamingSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = FunisgoStreamingSDK.test()
```


### Instance Methods

#### `Channel(data=None)`

Create a new `ChannelEntity` instance. Pass `None` for no initial data.

#### `Movie(data=None)`

Create a new `MovieEntity` instance. Pass `None` for no initial data.

#### `Series(data=None)`

Create a new `SeriesEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> dict`

Make a direct HTTP request to any API endpoint. Returns a result `dict` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `result_dict`

#### `prepare(fetchargs=None) -> dict`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## ChannelEntity

```python
channel = client.Channel()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `category` | `str` | No |  |
| `createdAt` | `str` | No |  |
| `description` | `str` | No |  |
| `id` | `str` | No |  |
| `isLive` | `bool` | No |  |
| `isPremium` | `bool` | No |  |
| `language` | `str` | No |  |
| `logoUrl` | `str` | No |  |
| `name` | `str` | No |  |
| `streamUrl` | `str` | No |  |
| `updatedAt` | `str` | No |  |

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

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.Channel().create({
})
```

#### `list(reqmatch=None, ctrl=None) -> list`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list and raises on error.

```python
results = client.Channel().list()
for channel in results:
    print(channel)
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.Channel().load({"id": "channel_id"})
```

#### `remove(reqmatch, ctrl=None) -> dict`

Remove the entity matching the given criteria. Raises on error.

```python
result = client.Channel().remove({"id": "channel_id"})
```

#### `update(reqdata, ctrl=None) -> dict`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```python
result = client.Channel().update({
    "id": "channel_id",
    # Fields to update
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ChannelEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## MovieEntity

```python
movie = client.Movie()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `createdAt` | `str` | No |  |
| `description` | `str` | No |  |
| `duration` | `int` | No | Duration in minutes |
| `genre` | `list` | No |  |
| `id` | `str` | No |  |
| `isPremium` | `bool` | No |  |
| `rating` | `float` | No |  |
| `releaseYear` | `int` | No |  |
| `streamUrl` | `str` | No |  |
| `thumbnailUrl` | `str` | No |  |
| `title` | `str` | No |  |
| `updatedAt` | `str` | No |  |

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

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.Movie().create({
})
```

#### `list(reqmatch=None, ctrl=None) -> list`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list and raises on error.

```python
results = client.Movie().list()
for movie in results:
    print(movie)
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.Movie().load({"id": "movie_id"})
```

#### `remove(reqmatch, ctrl=None) -> dict`

Remove the entity matching the given criteria. Raises on error.

```python
result = client.Movie().remove({"id": "movie_id"})
```

#### `update(reqdata, ctrl=None) -> dict`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```python
result = client.Movie().update({
    "id": "movie_id",
    # Fields to update
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `MovieEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SeriesEntity

```python
series = client.Series()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `createdAt` | `str` | No |  |
| `description` | `str` | No |  |
| `episodes` | `int` | No |  |
| `genre` | `list` | No |  |
| `id` | `str` | No |  |
| `isPremium` | `bool` | No |  |
| `rating` | `float` | No |  |
| `releaseYear` | `int` | No |  |
| `seasons` | `int` | No |  |
| `thumbnailUrl` | `str` | No |  |
| `title` | `str` | No |  |
| `updatedAt` | `str` | No |  |

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

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.Series().create({
})
```

#### `list(reqmatch=None, ctrl=None) -> list`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list and raises on error.

```python
results = client.Series().list()
for series in results:
    print(series)
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.Series().load({"id": "series_id"})
```

#### `remove(reqmatch, ctrl=None) -> dict`

Remove the entity matching the given criteria. Raises on error.

```python
result = client.Series().remove({"id": "series_id"})
```

#### `update(reqdata, ctrl=None) -> dict`

Update an existing entity. The data must include the entity `id`. Returns the updated entity data and raises on error.

```python
result = client.Series().update({
    "id": "series_id",
    # Fields to update
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SeriesEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```python
client = FunisgoStreamingSDK({
    "feature": {
        "test": {"active": True},
    },
})
```


### Configuring features

Each feature is inactive until switched on, and an SDK with no feature
configured does no feature work at all. Every option below keeps its default
unless you name it.

The array form of \`feature\` is significant: several features wrap the
transport, and the order you list them in is the order they nest.

#### `test`

In-memory mock transport for testing without a live server.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.test.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Installs the BASE transport that the wrapping features wrap, so it must be
  activated before them.
- Inactive by default: leaving it out costs nothing at runtime.

