require 'test_helper'

class RulersTest < Minitest::Test
  include Rack::Test::Methods

  def test_request
    get "/"
    assert_response :success
  end
end
