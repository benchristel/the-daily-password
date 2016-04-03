require 'minitest/autorun'
require_relative '../lib/weighted_array'

class WeightedArrayTest < Minitest::Test
  class FakeRandom
    def returning(n)
      @n = n
      self
    end

    def random_number
      @n
    end
  end

  def weighted_array
    WeightedArray.new(FakeRandom.new.returning(0))
  end

  def test_choose_returns_nil_when_array_is_empty
    assert_equal nil, weighted_array.choose
  end

  def test_choose_returns_lone_element
    assert_equal 'horse', weighted_array.add('horse', 1).choose
  end

  def test_choose_with_two_elements
    random = FakeRandom.new

    weighted_array = WeightedArray.new(random)
      .add('horse', 1)
      .add('duck', 1)

    random.returning(0)

    assert_equal 'horse', weighted_array.choose

    random.returning(0.49)

    assert_equal 'horse', weighted_array.choose

    random.returning(0.5)

    assert_equal 'duck', weighted_array.choose

    random.returning(0.99999)

    assert_equal 'duck', weighted_array.choose
  end

  def test_choose_with_weighted_elements
    random = FakeRandom.new

    weighted_array = WeightedArray.new(random)
      .add('horse', 1)
      .add('duck', 2)

    random.returning(0)

    assert_equal 'horse', weighted_array.choose

    random.returning(0.33)

    assert_equal 'horse', weighted_array.choose

    random.returning(0.34)

    assert_equal 'duck', weighted_array.choose

    random.returning(0.99999)

    assert_equal 'duck', weighted_array.choose
  end
end
