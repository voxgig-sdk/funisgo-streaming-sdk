package = "voxgig-sdk-funisgo-streaming"
version = "0.0-1"
source = {
  url = "git://github.com/voxgig-sdk/funisgo-streaming-sdk.git"
}
description = {
  summary = "FunisgoStreaming SDK for Lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["funisgo-streaming_sdk"] = "funisgo-streaming_sdk.lua",
    ["config"] = "config.lua",
    ["features"] = "features.lua",
  }
}
