require 'test_helper'

class RulersTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Rulers::VERSION
  end

  def test_request
    get "/"
    assert_response :success
  end
end
