# FunisgoStreaming TypeScript SDK



The TypeScript SDK for the FunisgoStreaming API — a type-safe, entity-oriented client with full async/await support.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to npm. Install it from the GitHub
release tag (`ts/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/funisgo-streaming-sdk/releases](https://github.com/voxgig-sdk/funisgo-streaming-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ts
import { FunisgoStreamingSDK } from '@voxgig-sdk/funisgo-streaming'

const client = new FunisgoStreamingSDK({
  apikey: process.env.FUNISGO_STREAMING_APIKEY,
})
```

### 2. List channels

```ts
const result = await client.channel.list()

if (result.ok) {
  for (const item of result.data) {
    console.log(item.id, item.name)
  }
}
```

### 3. Load a channel

```ts
const result = await client.channel.load({ id: 'example_id' })

if (result.ok) {
  console.log(result.data)
}
```

### 4. Create, update, and remove

```ts
// Create
const created = await client.channel.create({
  name: 'Example',
})

// Update
const updated = await client.channel.update({
  id: created.data.id,
  name: 'Example-Renamed',
})

// Remove
const removed = await client.channel.remove({
  id: created.data.id,
})
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})

if (result.ok) {
  console.log(result.status)  // 200
  console.log(result.data)    // response body
}
```

### Prepare a request without sending it

```ts
const fetchdef = await client.prepare({
  path: '/api/resource/{id}',
  method: 'DELETE',
  params: { id: 'example' },
})

// Inspect before sending
console.log(fetchdef.url)
console.log(fetchdef.method)
console.log(fetchdef.headers)
```

### Use test mode

Create a mock client for unit testing — no server required:

```ts
const client = FunisgoStreamingSDK.test()

const result = await client.channel.load({ id: 'test01' })
// result.ok === true
// result.data contains mock response data
```

You can also use the instance method:

```ts
const client = new FunisgoStreamingSDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.channel

// First call sets internal match
await entity.load({ id: 'example' })

// Subsequent calls reuse the stored match
const data = entity.data()
console.log(data.id) // 'example'
```

### Add custom middleware

Pass features via the `extend` option:

```ts
const logger = {
  hooks: {
    PreRequest: (ctx: any) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx: any) => {
      console.log('Status:', ctx.out.request?.status)
    },
  },
}

const client = new FunisgoStreamingSDK({
  apikey: '...',
  extend: [logger],
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
FUNISGO_STREAMING_TEST_LIVE=TRUE
FUNISGO_STREAMING_APIKEY=<your-key>
```

Then run:

```bash
cd ts && npm test
```


## Reference

### FunisgoStreamingSDK

#### Constructor

```ts
new FunisgoStreamingSDK(options?: {
  apikey?: string
  base?: string
  prefix?: string
  suffix?: string
  feature?: Record<string, { active: boolean }>
  extend?: Feature[]
})
```

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `object` | Feature activation flags (e.g. `{ test: { active: true } }`). |
| `extend` | `Feature[]` | Additional feature instances to load. |

#### Methods

| Method | Returns | Description |
| --- | --- | --- |
| `options()` | `object` | Deep copy of current SDK options. |
| `utility()` | `Utility` | Deep copy of the SDK utility object. |
| `prepare(fetchargs?)` | `Promise<FetchDef>` | Build an HTTP request definition without sending it. |
| `direct(fetchargs?)` | `Promise<DirectResult>` | Build and send an HTTP request. |
| `Channel(data?)` | `ChannelEntity` | Create a Channel entity instance. |
| `Movie(data?)` | `MovieEntity` | Create a Movie entity instance. |
| `Series(data?)` | `SeriesEntity` | Create a Series entity instance. |
| `tester(testopts?, sdkopts?)` | `FunisgoStreamingSDK` | Create a test-mode client instance. |

#### Static methods

| Method | Returns | Description |
| --- | --- | --- |
| `FunisgoStreamingSDK.test(testopts?, sdkopts?)` | `FunisgoStreamingSDK` | Create a test-mode client. |

### Entity interface

All entities share the same interface.

#### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `load(reqmatch?, ctrl?): Promise<Result>` | Load a single entity by match criteria. |
| `list` | `list(reqmatch?, ctrl?): Promise<Result>` | List entities matching the criteria. |
| `create` | `create(reqdata?, ctrl?): Promise<Result>` | Create a new entity. |
| `update` | `update(reqdata?, ctrl?): Promise<Result>` | Update an existing entity. |
| `remove` | `remove(reqmatch?, ctrl?): Promise<Result>` | Remove an entity. |
| `data` | `data(data?): any` | Get or set entity data. |
| `match` | `match(match?): any` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): FunisgoStreamingSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Result shape

All entity operations return a Result object:

```ts
{
  ok: boolean      // true if the HTTP status is 2xx
  status: number   // HTTP status code
  headers: object  // response headers
  data: any        // parsed JSON response body
}
```

### DirectResult shape

The `direct()` method returns:

```ts
{
  ok: boolean
  status: number
  headers: object
  data: any
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```ts
{
  url: string
  method: string
  headers: Record<string, string>
  body?: any
}
```

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

Operations: create, list, load, remove, update.

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

Operations: create, list, load, remove, update.

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

Operations: create, list, load, remove, update.

API path: `/series`



## Entities


### Channel

Create an instance: `const channel = client.channel`

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
const channel = await client.channel.load({ id: 'channel_id' })
```

#### Example: List

```ts
const channels = await client.channel.list()
```

#### Example: Create

```ts
const channel = await client.channel.create({
  category: /* `$STRING` */,
  description: /* `$STRING` */,
  name: /* `$STRING` */,
})
```


### Movie

Create an instance: `const movie = client.movie`

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
const movie = await client.movie.load({ id: 'movie_id' })
```

#### Example: List

```ts
const movies = await client.movie.list()
```

#### Example: Create

```ts
const movie = await client.movie.create({
  description: /* `$STRING` */,
  duration: /* `$INTEGER` */,
  genre: /* `$ARRAY` */,
  release_year: /* `$INTEGER` */,
  title: /* `$STRING` */,
})
```


### Series

Create an instance: `const series = client.series`

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
const series = await client.series.load({ id: 'series_id' })
```

#### Example: List

```ts
const seriess = await client.series.list()
```

#### Example: Create

```ts
const series = await client.series.create({
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
error is returned to the caller.

An unexpected exception triggers the `PreUnexpected` hook before
propagating.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Module structure

```
funisgo-streaming/
├── src/
│   ├── FunisgoStreamingSDK.ts        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
├── test/                   # Test suites
└── dist/                   # Compiled output
```

Import the SDK from the package root:

```ts
import { FunisgoStreamingSDK } from '@voxgig-sdk/funisgo-streaming'
```

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const channel = client.channel
await channel.load({ id: "example_id" })

// channel.data() now returns the loaded channel data
// channel.match() returns { id: "example_id" }
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
