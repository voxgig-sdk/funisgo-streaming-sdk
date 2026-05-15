# FunisgoStreaming SDK exists test

require "minitest/autorun"
require_relative "../FunisgoStreaming_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = FunisgoStreamingSDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
