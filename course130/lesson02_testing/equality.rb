require 'minitest/autorun'

class EqualityTest < Minitest::Test
  def test_value_equality
    s1 = "hi there"
    s2 = "hi there"
    assert_equal(s1, s2)
    assert_same(s1, s2)
  end
end