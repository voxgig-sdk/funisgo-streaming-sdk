# FunisgoStreaming SDK utility: feature_add
module FunisgoStreamingUtilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
