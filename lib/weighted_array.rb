class WeightedArray
  include Enumerable

  def initialize(random)
    @random = random
    @items = []
    @weights = []
    @total_weight = 0
  end

  def add(thing, weight)
    @items << thing
    @weights << weight
    @total_weight += weight
    self
  end

  def choose
    return nil if @items.empty?

    how_much_farther = @random.random_number * @total_weight

    @items.each_with_index do |item, index|
      how_much_farther -= @weights[index]
      return item if how_much_farther < 0
    end

    raise 'nothing returned!'
  end

  def each(*args, &block)
    @items.each(*args, &block)
  end
end
