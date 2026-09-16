# FunisgoStreaming SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module FunisgoStreamingFeatures
  def self.make_feature(name)
    case name
    when "base"
      FunisgoStreamingBaseFeature.new
    when "ratelimit"
      FunisgoStreamingRatelimitFeature.new
    when "retry"
      FunisgoStreamingRetryFeature.new
    when "test"
      FunisgoStreamingTestFeature.new
    when "timeout"
      FunisgoStreamingTimeoutFeature.new
    else
      FunisgoStreamingBaseFeature.new
    end
  end
end
