-- FunisgoStreaming SDK exists test

local sdk = require("funisgo-streaming_sdk")

describe("FunisgoStreamingSDK", function()
  it("should create test SDK", function()
    local testsdk = sdk.test(nil, nil)
    assert.is_not_nil(testsdk)
  end)
end)
