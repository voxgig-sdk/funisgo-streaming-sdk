# FunisgoStreaming SDK utility: prepare_body
module FunisgoStreamingUtilities
  PrepareBody = ->(ctx) {
    ctx.op.input == "data" ? ctx.utility.transform_request.call(ctx) : nil
  }
end
