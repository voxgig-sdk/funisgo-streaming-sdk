# FunisgoStreaming SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module FunisgoStreamingFeatures
  def self.make_feature(name)
    case name
    when "base"
      FunisgoStreamingBaseFeature.new
    when "test"
      FunisgoStreamingTestFeature.new
    else
      FunisgoStreamingBaseFeature.new
    end
  end
end
