-- FunisgoStreaming SDK configuration

local function make_config()
  return {
    main = {
      name = "FunisgoStreaming",
    },
    feature = {
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
      },
    },
    options = {
      base = "https://api.funisgo.com",
      auth = {
        prefix = "",
      },
      headers = {
        ["content-type"] = "application/json",
      },
      entity = {
        ["channel"] = {},
        ["movie"] = {},
        ["series"] = {},
      },
    },
    entity = {
      ["channel"] = {
        ["fields"] = {
          {
            ["active"] = true,
            ["name"] = "category",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
            },
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 0,
          },
          {
            ["active"] = true,
            ["name"] = "createdAt",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 1,
          },
          {
            ["active"] = true,
            ["name"] = "description",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
            },
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 2,
          },
          {
            ["active"] = true,
            ["name"] = "id",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 3,
          },
          {
            ["active"] = true,
            ["name"] = "isLive",
            ["req"] = false,
            ["type"] = "`$BOOLEAN`",
            ["index$"] = 4,
          },
          {
            ["active"] = true,
            ["name"] = "isPremium",
            ["req"] = false,
            ["type"] = "`$BOOLEAN`",
            ["index$"] = 5,
          },
          {
            ["active"] = true,
            ["name"] = "language",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 6,
          },
          {
            ["active"] = true,
            ["name"] = "logoUrl",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 7,
          },
          {
            ["active"] = true,
            ["name"] = "name",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
            },
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 8,
          },
          {
            ["active"] = true,
            ["name"] = "streamUrl",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 9,
          },
          {
            ["active"] = true,
            ["name"] = "updatedAt",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 10,
          },
        },
        ["name"] = "channel",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "POST",
                ["orig"] = "/channels",
                ["parts"] = {
                  "channels",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "create",
          },
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["query"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "query",
                      ["name"] = "category",
                      ["orig"] = "category",
                      ["reqd"] = false,
                      ["type"] = "`$STRING`",
                    },
                    {
                      ["active"] = true,
                      ["example"] = 20,
                      ["kind"] = "query",
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["reqd"] = false,
                      ["type"] = "`$INTEGER`",
                    },
                    {
                      ["active"] = true,
                      ["example"] = 1,
                      ["kind"] = "query",
                      ["name"] = "page",
                      ["orig"] = "page",
                      ["reqd"] = false,
                      ["type"] = "`$INTEGER`",
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/channels",
                ["parts"] = {
                  "channels",
                },
                ["select"] = {
                  ["exist"] = {
                    "category",
                    "limit",
                    "page",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "list",
          },
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["params"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "param",
                      ["name"] = "id",
                      ["orig"] = "channel_id",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                      ["index$"] = 0,
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/channels/{channelId}",
                ["parts"] = {
                  "channels",
                  "{id}",
                },
                ["rename"] = {
                  ["param"] = {
                    ["channelId"] = "id",
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "id",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "load",
          },
          ["remove"] = {
            ["input"] = "data",
            ["name"] = "remove",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["params"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "param",
                      ["name"] = "id",
                      ["orig"] = "channel_id",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                      ["index$"] = 0,
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "DELETE",
                ["orig"] = "/channels/{channelId}",
                ["parts"] = {
                  "channels",
                  "{id}",
                },
                ["rename"] = {
                  ["param"] = {
                    ["channelId"] = "id",
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "id",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "remove",
          },
          ["update"] = {
            ["input"] = "data",
            ["name"] = "update",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["params"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "param",
                      ["name"] = "id",
                      ["orig"] = "channel_id",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                      ["index$"] = 0,
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "PUT",
                ["orig"] = "/channels/{channelId}",
                ["parts"] = {
                  "channels",
                  "{id}",
                },
                ["rename"] = {
                  ["param"] = {
                    ["channelId"] = "id",
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "id",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "update",
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["movie"] = {
        ["fields"] = {
          {
            ["active"] = true,
            ["name"] = "createdAt",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 0,
          },
          {
            ["active"] = true,
            ["name"] = "description",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
            },
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 1,
          },
          {
            ["active"] = true,
            ["name"] = "duration",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$INTEGER`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$INTEGER`",
              },
            },
            ["req"] = false,
            ["type"] = "`$INTEGER`",
            ["index$"] = 2,
          },
          {
            ["active"] = true,
            ["name"] = "genre",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$ARRAY`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$ARRAY`",
              },
            },
            ["req"] = false,
            ["type"] = "`$ARRAY`",
            ["index$"] = 3,
          },
          {
            ["active"] = true,
            ["name"] = "id",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 4,
          },
          {
            ["active"] = true,
            ["name"] = "isPremium",
            ["req"] = false,
            ["type"] = "`$BOOLEAN`",
            ["index$"] = 5,
          },
          {
            ["active"] = true,
            ["name"] = "rating",
            ["req"] = false,
            ["type"] = "`$NUMBER`",
            ["index$"] = 6,
          },
          {
            ["active"] = true,
            ["name"] = "releaseYear",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$INTEGER`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$INTEGER`",
              },
            },
            ["req"] = false,
            ["type"] = "`$INTEGER`",
            ["index$"] = 7,
          },
          {
            ["active"] = true,
            ["name"] = "streamUrl",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 8,
          },
          {
            ["active"] = true,
            ["name"] = "thumbnailUrl",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 9,
          },
          {
            ["active"] = true,
            ["name"] = "title",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
            },
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 10,
          },
          {
            ["active"] = true,
            ["name"] = "updatedAt",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 11,
          },
        },
        ["name"] = "movie",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "POST",
                ["orig"] = "/movies",
                ["parts"] = {
                  "movies",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "create",
          },
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["query"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "query",
                      ["name"] = "genre",
                      ["orig"] = "genre",
                      ["reqd"] = false,
                      ["type"] = "`$STRING`",
                    },
                    {
                      ["active"] = true,
                      ["example"] = 20,
                      ["kind"] = "query",
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["reqd"] = false,
                      ["type"] = "`$INTEGER`",
                    },
                    {
                      ["active"] = true,
                      ["example"] = 1,
                      ["kind"] = "query",
                      ["name"] = "page",
                      ["orig"] = "page",
                      ["reqd"] = false,
                      ["type"] = "`$INTEGER`",
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/movies",
                ["parts"] = {
                  "movies",
                },
                ["select"] = {
                  ["exist"] = {
                    "genre",
                    "limit",
                    "page",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "list",
          },
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["params"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "param",
                      ["name"] = "id",
                      ["orig"] = "movie_id",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                      ["index$"] = 0,
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/movies/{movieId}",
                ["parts"] = {
                  "movies",
                  "{id}",
                },
                ["rename"] = {
                  ["param"] = {
                    ["movieId"] = "id",
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "id",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "load",
          },
          ["remove"] = {
            ["input"] = "data",
            ["name"] = "remove",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["params"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "param",
                      ["name"] = "id",
                      ["orig"] = "movie_id",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                      ["index$"] = 0,
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "DELETE",
                ["orig"] = "/movies/{movieId}",
                ["parts"] = {
                  "movies",
                  "{id}",
                },
                ["rename"] = {
                  ["param"] = {
                    ["movieId"] = "id",
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "id",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "remove",
          },
          ["update"] = {
            ["input"] = "data",
            ["name"] = "update",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["params"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "param",
                      ["name"] = "id",
                      ["orig"] = "movie_id",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                      ["index$"] = 0,
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "PUT",
                ["orig"] = "/movies/{movieId}",
                ["parts"] = {
                  "movies",
                  "{id}",
                },
                ["rename"] = {
                  ["param"] = {
                    ["movieId"] = "id",
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "id",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "update",
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["series"] = {
        ["fields"] = {
          {
            ["active"] = true,
            ["name"] = "createdAt",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 0,
          },
          {
            ["active"] = true,
            ["name"] = "description",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
            },
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 1,
          },
          {
            ["active"] = true,
            ["name"] = "episodes",
            ["req"] = false,
            ["type"] = "`$INTEGER`",
            ["index$"] = 2,
          },
          {
            ["active"] = true,
            ["name"] = "genre",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$ARRAY`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$ARRAY`",
              },
            },
            ["req"] = false,
            ["type"] = "`$ARRAY`",
            ["index$"] = 3,
          },
          {
            ["active"] = true,
            ["name"] = "id",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 4,
          },
          {
            ["active"] = true,
            ["name"] = "isPremium",
            ["req"] = false,
            ["type"] = "`$BOOLEAN`",
            ["index$"] = 5,
          },
          {
            ["active"] = true,
            ["name"] = "rating",
            ["req"] = false,
            ["type"] = "`$NUMBER`",
            ["index$"] = 6,
          },
          {
            ["active"] = true,
            ["name"] = "releaseYear",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$INTEGER`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$INTEGER`",
              },
            },
            ["req"] = false,
            ["type"] = "`$INTEGER`",
            ["index$"] = 7,
          },
          {
            ["active"] = true,
            ["name"] = "seasons",
            ["req"] = false,
            ["type"] = "`$INTEGER`",
            ["index$"] = 8,
          },
          {
            ["active"] = true,
            ["name"] = "thumbnailUrl",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 9,
          },
          {
            ["active"] = true,
            ["name"] = "title",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
              ["update"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
            },
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 10,
          },
          {
            ["active"] = true,
            ["name"] = "updatedAt",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 11,
          },
        },
        ["name"] = "series",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "POST",
                ["orig"] = "/series",
                ["parts"] = {
                  "series",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "create",
          },
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["query"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "query",
                      ["name"] = "genre",
                      ["orig"] = "genre",
                      ["reqd"] = false,
                      ["type"] = "`$STRING`",
                    },
                    {
                      ["active"] = true,
                      ["example"] = 20,
                      ["kind"] = "query",
                      ["name"] = "limit",
                      ["orig"] = "limit",
                      ["reqd"] = false,
                      ["type"] = "`$INTEGER`",
                    },
                    {
                      ["active"] = true,
                      ["example"] = 1,
                      ["kind"] = "query",
                      ["name"] = "page",
                      ["orig"] = "page",
                      ["reqd"] = false,
                      ["type"] = "`$INTEGER`",
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/series",
                ["parts"] = {
                  "series",
                },
                ["select"] = {
                  ["exist"] = {
                    "genre",
                    "limit",
                    "page",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "list",
          },
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["params"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "param",
                      ["name"] = "id",
                      ["orig"] = "series_id",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                      ["index$"] = 0,
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/series/{seriesId}",
                ["parts"] = {
                  "series",
                  "{id}",
                },
                ["rename"] = {
                  ["param"] = {
                    ["seriesId"] = "id",
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "id",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "load",
          },
          ["remove"] = {
            ["input"] = "data",
            ["name"] = "remove",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["params"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "param",
                      ["name"] = "id",
                      ["orig"] = "series_id",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                      ["index$"] = 0,
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "DELETE",
                ["orig"] = "/series/{seriesId}",
                ["parts"] = {
                  "series",
                  "{id}",
                },
                ["rename"] = {
                  ["param"] = {
                    ["seriesId"] = "id",
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "id",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "remove",
          },
          ["update"] = {
            ["input"] = "data",
            ["name"] = "update",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["params"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "param",
                      ["name"] = "id",
                      ["orig"] = "series_id",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                      ["index$"] = 0,
                    },
                  },
                },
                ["kind"] = "http",
                ["method"] = "PUT",
                ["orig"] = "/series/{seriesId}",
                ["parts"] = {
                  "series",
                  "{id}",
                },
                ["rename"] = {
                  ["param"] = {
                    ["seriesId"] = "id",
                  },
                },
                ["select"] = {
                  ["exist"] = {
                    "id",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body.data`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "update",
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
    },
  }
end


local function make_feature(name)
  local features = require("features")
  local factory = features[name]
  if factory ~= nil then
    return factory()
  end
  return features.base()
end


-- Attach make_feature to the SDK class
local function setup_sdk(SDK)
  SDK._make_feature = make_feature
end


return make_config
