# FunisgoStreaming TypeScript SDK Reference

Complete API reference for the FunisgoStreaming TypeScript SDK.


## FunisgoStreamingSDK

### Constructor

```ts
new FunisgoStreamingSDK(options?: object)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `object` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `object` | Custom headers for all requests. |
| `options.feature` | `object` | Feature configuration. |
| `options.system` | `object` | System overrides (e.g. custom fetch). |


### Static Methods

#### `FunisgoStreamingSDK.test(testopts?, sdkopts?)`

Create a test client with mock features active.

```ts
const client = FunisgoStreamingSDK.test()
```

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `testopts` | `object` | Test feature options. |
| `sdkopts` | `object` | Additional SDK options merged with test defaults. |

**Returns:** `FunisgoStreamingSDK` instance in test mode.


### Instance Methods

#### `Channel(data?: object)`

Create a new `Channel` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ChannelEntity` instance.

#### `Movie(data?: object)`

Create a new `Movie` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `MovieEntity` instance.

#### `Series(data?: object)`

Create a new `Series` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `SeriesEntity` instance.

#### `options()`

Return a deep copy of the current SDK options.

**Returns:** `object`

#### `utility()`

Return a copy of the SDK utility object.

**Returns:** `object`

#### `direct(fetchargs?: object)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `GET`). |
| `fetchargs.params` | `object` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `object` | Query string parameters. |
| `fetchargs.headers` | `object` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (objects are JSON-serialized). |
| `fetchargs.ctrl` | `object` | Control options (e.g. `{ explain: true }`). |

**Returns:** `Promise<{ ok, status, headers, data } | Error>`

#### `prepare(fetchargs?: object)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `Promise<{ url, method, headers, body } | Error>`

#### `tester(testopts?, sdkopts?)`

Alias for `FunisgoStreamingSDK.test()`.

**Returns:** `FunisgoStreamingSDK` instance in test mode.


---

## ChannelEntity

```ts
const channel = client.channel
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.channel.create({
  category: /* `$STRING` */,
  description: /* `$STRING` */,
  name: /* `$STRING` */,
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.channel.list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.channel.load({ id: 'channel_id' })
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.channel.remove({ id: 'channel_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.channel.update({
  id: 'channel_id',
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ChannelEntity` instance with the same client and
options.

#### `client()`

Return the parent `FunisgoStreamingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## MovieEntity

```ts
const movie = client.movie
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.movie.create({
  description: /* `$STRING` */,
  duration: /* `$INTEGER` */,
  genre: /* `$ARRAY` */,
  release_year: /* `$INTEGER` */,
  title: /* `$STRING` */,
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.movie.list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.movie.load({ id: 'movie_id' })
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.movie.remove({ id: 'movie_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.movie.update({
  id: 'movie_id',
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `MovieEntity` instance with the same client and
options.

#### `client()`

Return the parent `FunisgoStreamingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## SeriesEntity

```ts
const series = client.series
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.series.create({
  description: /* `$STRING` */,
  genre: /* `$ARRAY` */,
  release_year: /* `$INTEGER` */,
  title: /* `$STRING` */,
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.series.list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.series.load({ id: 'series_id' })
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.series.remove({ id: 'series_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.series.update({
  id: 'series_id',
  // Fields to update
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `SeriesEntity` instance with the same client and
options.

#### `client()`

Return the parent `FunisgoStreamingSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ts
const client = new FunisgoStreamingSDK({
  feature: {
    test: { active: true },
  }
})
```

