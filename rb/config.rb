# FunisgoStreaming SDK configuration

module FunisgoStreamingConfig
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "FunisgoStreaming",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
        },
      },
      "options" => {
        "base" => "https://api.funisgo.com",
        "auth" => {
          "prefix" => "",
        },
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "channel" => {},
          "movie" => {},
          "series" => {},
        },
      },
      "entity" => {
        "channel" => {
          "fields" => [
            {
              "name" => "category",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "type" => "`$STRING`",
            },
            {
              "name" => "createdAt",
              "type" => "`$STRING`",
            },
            {
              "name" => "description",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "type" => "`$STRING`",
            },
            {
              "name" => "isLive",
              "type" => "`$BOOLEAN`",
            },
            {
              "name" => "isPremium",
              "type" => "`$BOOLEAN`",
            },
            {
              "name" => "language",
              "type" => "`$STRING`",
            },
            {
              "name" => "logoUrl",
              "type" => "`$STRING`",
            },
            {
              "name" => "name",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "type" => "`$STRING`",
            },
            {
              "name" => "streamUrl",
              "type" => "`$STRING`",
            },
            {
              "name" => "updatedAt",
              "type" => "`$STRING`",
            },
          ],
          "name" => "channel",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/channels",
                  "parts" => [
                    "channels",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.data`",
                  },
                },
              ],
            },
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "category",
                        "orig" => "category",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 20,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 1,
                        "kind" => "query",
                        "name" => "page",
                        "orig" => "page",
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/channels",
                  "parts" => [
                    "channels",
                  ],
                  "select" => {
                    "exist" => [
                      "category",
                      "limit",
                      "page",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "channel_id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/channels/{channelId}",
                  "parts" => [
                    "channels",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "channelId" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.data`",
                  },
                },
              ],
            },
            "remove" => {
              "input" => "data",
              "name" => "remove",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "channel_id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "DELETE",
                  "orig" => "/channels/{channelId}",
                  "parts" => [
                    "channels",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "channelId" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "update" => {
              "input" => "data",
              "name" => "update",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "channel_id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "PUT",
                  "orig" => "/channels/{channelId}",
                  "parts" => [
                    "channels",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "channelId" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.data`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "movie" => {
          "fields" => [
            {
              "name" => "createdAt",
              "type" => "`$STRING`",
            },
            {
              "name" => "description",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "type" => "`$STRING`",
            },
            {
              "name" => "duration",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$INTEGER`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$INTEGER`",
                },
              },
              "type" => "`$INTEGER`",
            },
            {
              "name" => "genre",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
              "type" => "`$ARRAY`",
            },
            {
              "name" => "id",
              "type" => "`$STRING`",
            },
            {
              "name" => "isPremium",
              "type" => "`$BOOLEAN`",
            },
            {
              "name" => "rating",
              "type" => "`$NUMBER`",
            },
            {
              "name" => "releaseYear",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$INTEGER`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$INTEGER`",
                },
              },
              "type" => "`$INTEGER`",
            },
            {
              "name" => "streamUrl",
              "type" => "`$STRING`",
            },
            {
              "name" => "thumbnailUrl",
              "type" => "`$STRING`",
            },
            {
              "name" => "title",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "type" => "`$STRING`",
            },
            {
              "name" => "updatedAt",
              "type" => "`$STRING`",
            },
          ],
          "name" => "movie",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/movies",
                  "parts" => [
                    "movies",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.data`",
                  },
                },
              ],
            },
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "genre",
                        "orig" => "genre",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 20,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 1,
                        "kind" => "query",
                        "name" => "page",
                        "orig" => "page",
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/movies",
                  "parts" => [
                    "movies",
                  ],
                  "select" => {
                    "exist" => [
                      "genre",
                      "limit",
                      "page",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "movie_id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/movies/{movieId}",
                  "parts" => [
                    "movies",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "movieId" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.data`",
                  },
                },
              ],
            },
            "remove" => {
              "input" => "data",
              "name" => "remove",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "movie_id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "DELETE",
                  "orig" => "/movies/{movieId}",
                  "parts" => [
                    "movies",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "movieId" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "update" => {
              "input" => "data",
              "name" => "update",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "movie_id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "PUT",
                  "orig" => "/movies/{movieId}",
                  "parts" => [
                    "movies",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "movieId" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.data`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "series" => {
          "fields" => [
            {
              "name" => "createdAt",
              "type" => "`$STRING`",
            },
            {
              "name" => "description",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "type" => "`$STRING`",
            },
            {
              "name" => "episodes",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "genre",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$ARRAY`",
                },
              },
              "type" => "`$ARRAY`",
            },
            {
              "name" => "id",
              "type" => "`$STRING`",
            },
            {
              "name" => "isPremium",
              "type" => "`$BOOLEAN`",
            },
            {
              "name" => "rating",
              "type" => "`$NUMBER`",
            },
            {
              "name" => "releaseYear",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$INTEGER`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$INTEGER`",
                },
              },
              "type" => "`$INTEGER`",
            },
            {
              "name" => "seasons",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "thumbnailUrl",
              "type" => "`$STRING`",
            },
            {
              "name" => "title",
              "op" => {
                "create" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
                "update" => {
                  "req" => true,
                  "type" => "`$STRING`",
                },
              },
              "type" => "`$STRING`",
            },
            {
              "name" => "updatedAt",
              "type" => "`$STRING`",
            },
          ],
          "name" => "series",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/series",
                  "parts" => [
                    "series",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.data`",
                  },
                },
              ],
            },
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "genre",
                        "orig" => "genre",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 20,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 1,
                        "kind" => "query",
                        "name" => "page",
                        "orig" => "page",
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/series",
                  "parts" => [
                    "series",
                  ],
                  "select" => {
                    "exist" => [
                      "genre",
                      "limit",
                      "page",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "series_id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/series/{seriesId}",
                  "parts" => [
                    "series",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "seriesId" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.data`",
                  },
                },
              ],
            },
            "remove" => {
              "input" => "data",
              "name" => "remove",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "series_id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "DELETE",
                  "orig" => "/series/{seriesId}",
                  "parts" => [
                    "series",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "seriesId" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "update" => {
              "input" => "data",
              "name" => "update",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "series_id",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "PUT",
                  "orig" => "/series/{seriesId}",
                  "parts" => [
                    "series",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "seriesId" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.data`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    FunisgoStreamingFeatures.make_feature(name)
  end
end
