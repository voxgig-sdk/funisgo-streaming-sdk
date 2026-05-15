# FunisgoStreaming SDK utility: make_context
require_relative '../core/context'
module FunisgoStreamingUtilities
  MakeContext = ->(ctxmap, basectx) {
    FunisgoStreamingContext.new(ctxmap, basectx)
  }
end
