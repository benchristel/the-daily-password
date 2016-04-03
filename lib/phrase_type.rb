class PhraseType
  def initialize(string)
    @patterns_string = string
  end

  def choose
    patterns.choose.expand
  end

  def entropy
    patterns.map(&:entropy).reduce(0, :+)
  end

  def patterns
    @patterns ||= @patterns_string
        .split("\n").map(&:strip).reject(&:empty?)
        .map(&Pattern.method(:new))
        .reduce(WeightedArray.new(SecureRandom)) do |weighted_array, pattern|
          weighted_array.add(pattern, pattern.entropy)
        end
  end

  private

  def new_pattern
    Pattern.new(SecureRandom)
  end
end

class Pattern
  def initialize(string)
    @string = string
  end

  def entropy
    phrase_types.map(&:entropy).reduce(1, :*)
  end

  def expand
    @string.split(/[\[\]]/).each_with_index.map do |segment, index|
      if index % 2 == 1
        uninflected = phrase_type(segment).choose
        inflections(segment).reduce(uninflected) do |word, inflection|
          inflection.apply(word)
        end
      else
        segment
      end
    end.join('')
  end

  private

  def phrase_types
    @string.split(/[\[\]]/).each_with_index
      .reject { |_, index| index % 2 == 0 }
      .map { |name, _| phrase_type(name) }
  end

  def phrase_type(string)
    name = string.split('.')[0]
    Kernel.const_get name.upcase
  end

  def inflections(string)
    string.split('.')[1 .. -1].map do |name|
      Kernel.const_get name.upcase
    end
  end
end
