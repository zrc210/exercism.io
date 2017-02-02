module BookKeeping
  VERSION = 2
end

module StringRefinements
  refine String do
    def canonical_id
      downcase.chars.sort
    end

    def anagram?(other_string)
      !casecmp(other_string).zero? &&
        canonical_id == other_string.canonical_id
    end
  end
end

using StringRefinements

class Anagram
  def initialize(base_word)
    @base_word = base_word
  end

  def match(candidate_words)
    candidate_words.select do |word|
      base_word.anagram?(word)
    end
  end

  private

  attr_reader :base_word
end
