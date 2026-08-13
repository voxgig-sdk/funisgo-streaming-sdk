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
const channel = client.Channel()
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Channel().create({
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Channel().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Channel().load({ id: 'channel_id' })
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.Channel().remove({ id: 'channel_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.Channel().update({
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
const movie = client.Movie()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `createdAt` | `string` | No |  |
| `description` | `string` | No |  |
| `duration` | `number` | No |  |
| `genre` | `any[]` | No |  |
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Movie().create({
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Movie().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Movie().load({ id: 'movie_id' })
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.Movie().remove({ id: 'movie_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.Movie().update({
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
const series = client.Series()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `createdAt` | `string` | No |  |
| `description` | `string` | No |  |
| `episodes` | `number` | No |  |
| `genre` | `any[]` | No |  |
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Series().create({
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Series().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Series().load({ id: 'series_id' })
```

#### `remove(match: object, ctrl?: object)`

Remove the entity matching the given criteria.

```ts
const result = await client.Series().remove({ id: 'series_id' })
```

#### `update(data: object, ctrl?: object)`

Update an existing entity. The data must include the entity `id`.

```ts
const result = await client.Series().update({
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

