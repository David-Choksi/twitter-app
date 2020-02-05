require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,                 "Ruby Rails App"
    assert_equal full_title("Help"), "Help | Ruby Rails App"
    assert_equal full_title("Sign Up"), "Sign Up | Ruby Rails App"
  end
end

