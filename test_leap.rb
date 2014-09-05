require './leap'
require 'test/unit'


class TestLeap < Test::Unit::TestCase
 
  def test_2001_is_common_year
    assert_equal COMMON, leap(2001)
  end

  def test_1996_is_leap_year
    assert_equal LEAP, leap(1996)
  end

  def test_1900_is_common_year
    assert_equal COMMON, leap(1900)
  end

  def test_2000_is_leap_year
    assert_equal LEAP, leap(2000)
  end

end
