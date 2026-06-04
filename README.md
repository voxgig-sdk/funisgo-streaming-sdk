# FunisgoStreaming SDK

Browse streaming catalogues of movies, series and channels with free and premium tiers

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

## About FunisGo Streaming API

The [FunisGo Streaming API](https://api.funisgo.com) exposes a structured catalogue of streaming content - movies, TV series and channel listings - intended for client apps and aggregators. It is listed on [Free Public APIs](https://freepublicapis.com/funisgo-streaming-api), which also surfaces health and reliability metrics for individual endpoints.

What you get from the API:

- Lists of channels available for streaming
- Lists of movies in the catalogue
- Lists of TV series in the catalogue
- Content creation and editing operations on premium plans

Authentication is via a `token` query parameter; a public anonymous token (`anony_0000_public_56`) is documented for free-tier read access. Free and premium plans differ in usage limits and write capabilities. No formal licence terms are published; treat data as third-party content and check with the operator before redistribution.

## Try it

**TypeScript**
```bash
npm install funisgo-streaming
```

**Python**
```bash
pip install funisgo-streaming-sdk
```

**PHP**
```bash
composer require voxgig/funisgo-streaming-sdk
```

**Golang**
```bash
go get github.com/voxgig-sdk/funisgo-streaming-sdk/go
```

**Ruby**
```bash
gem install funisgo-streaming-sdk
```

**Lua**
```bash
luarocks install funisgo-streaming-sdk
```

## 30-second quickstart

### TypeScript

```ts
import { FunisgoStreamingSDK } from 'funisgo-streaming'

const client = new FunisgoStreamingSDK({})

// List all channels
const channels = await client.Channel().list()
```

See the [TypeScript README](ts/README.md) for the
full guide, or scroll down for the same example in other languages.

## What's in the box

| Surface | Use it for | Path |
| --- | --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | App integration | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | Scripts, CI, ops, one-off API calls | `go-cli/` |
| **MCP server** | AI agents (Claude, Cursor, Cline) | `go-mcp/` |

## Use it from an AI agent (MCP)

The generated MCP server exposes every operation in this SDK as an
[MCP](https://modelcontextprotocol.io) tool that Claude, Cursor or Cline
can call directly. Build and register it:

```bash
cd go-mcp && go build -o funisgo-streaming-mcp .
```

Then add it to your agent's MCP config (Claude Desktop, Cursor, etc.):

```json
{
  "mcpServers": {
    "funisgo-streaming": {
      "command": "/abs/path/to/funisgo-streaming-mcp"
    }
  }
}
```

## Entities

The API exposes 3 entities:

| Entity | Description | API path |
| --- | --- | --- |
| **Channel** | A live or on-demand streaming channel exposed via the channels list endpoint. | `/channels` |
| **Movie** | A movie title in the FunisGo catalogue, retrievable via the movies list endpoint. | `/movies` |
| **Series** | A TV series in the FunisGo catalogue, retrievable via the series list endpoint. | `/series` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
from funisgostreaming_sdk import FunisgoStreamingSDK

client = FunisgoStreamingSDK({})

# List all channels
channels, err = client.Channel(None).list(None, None)

# Load a specific channel
channel, err = client.Channel(None).load(
    {"id": "example_id"}, None
)
```

### PHP

```php
<?php
require_once 'funisgostreaming_sdk.php';

$client = new FunisgoStreamingSDK([]);

// List all channels
[$channels, $err] = $client->Channel(null)->list(null, null);

// Load a specific channel
[$channel, $err] = $client->Channel(null)->load(
    ["id" => "example_id"], null
);
```

### Golang

```go
import sdk "github.com/voxgig-sdk/funisgo-streaming-sdk/go"

client := sdk.NewFunisgoStreamingSDK(map[string]any{})

// List all channels
channels, err := client.Channel(nil).List(nil, nil)
```

### Ruby

```ruby
require_relative "FunisgoStreaming_sdk"

client = FunisgoStreamingSDK.new({})

# List all channels
channels, err = client.Channel(nil).list(nil, nil)

# Load a specific channel
channel, err = client.Channel(nil).load(
  { "id" => "example_id" }, nil
)
```

### Lua

```lua
local sdk = require("funisgo-streaming_sdk")

local client = sdk.new({})

-- List all channels
local channels, err = client:Channel(nil):list(nil, nil)

-- Load a specific channel
local channel, err = client:Channel(nil):load(
  { id = "example_id" }, nil
)
```

## Unit testing in offline mode

Every SDK ships a test mode that swaps the HTTP transport for an
in-memory mock, so unit tests run offline.

### TypeScript

```ts
const client = FunisgoStreamingSDK.test()
const result = await client.Channel().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```

### Python

```python
client = FunisgoStreamingSDK.test(None, None)
result, err = client.Channel(None).load(
    {"id": "test01"}, None
)
```

### PHP

```php
$client = FunisgoStreamingSDK::test(null, null);
[$result, $err] = $client->Channel(null)->load(
    ["id" => "test01"], null
);
```

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.Channel(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = FunisgoStreamingSDK.test(nil, nil)
result, err = client.Channel(nil).load(
  { "id" => "test01" }, nil
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:Channel(nil):load(
  { id = "test01" }, nil
)
```

## How it works

Every SDK call runs the same five-stage pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

A feature hook fires at each stage (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), so features can inspect or modify the pipeline without
forking the SDK.

### Features

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

Pass custom features via the `extend` option at construction time.

### Direct and Prepare

For endpoints the entity model doesn't cover, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`,
`headers`, and `body`. See the [How-to guides](#how-to-guides) below.

## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})
```

**PHP:**
```php
[$result, $err] = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);
```

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
```

**Ruby:**
```ruby
result, err = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})
```

**Lua:**
```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
```

## Per-language documentation

- [TypeScript](ts/README.md)
- [Python](py/README.md)
- [PHP](php/README.md)
- [Golang](go/README.md)
- [Ruby](rb/README.md)
- [Lua](lua/README.md)

## Using the FunisGo Streaming API

- Upstream: [https://api.funisgo.com](https://api.funisgo.com)
- API docs: [https://freepublicapis.com/funisgo-streaming-api](https://freepublicapis.com/funisgo-streaming-api)

---

Generated from the FunisGo Streaming API OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
