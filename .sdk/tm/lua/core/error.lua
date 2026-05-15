-- FunisgoStreaming SDK error

local FunisgoStreamingError = {}
FunisgoStreamingError.__index = FunisgoStreamingError


function FunisgoStreamingError.new(code, msg, ctx)
  local self = setmetatable({}, FunisgoStreamingError)
  self.is_sdk_error = true
  self.sdk = "FunisgoStreaming"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function FunisgoStreamingError:error()
  return self.msg
end


function FunisgoStreamingError:__tostring()
  return self.msg
end


return FunisgoStreamingError
