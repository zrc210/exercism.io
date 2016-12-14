module BookKeeping
  VERSION = 1
end

class Phrase
  def initialize(phrase, valid_word_chars = /[A-Za-z0-9']+/)
    @phrase = phrase
    @valid_word_chars = valid_word_chars
  end

  def word_count
    phrase
      .scan(valid_word_chars)
      .group_by { |word| sanitize_word(word) }
      .map { |word, instances| [word, instances.size]}
      .to_h
  end

  private

  attr_reader :phrase, :valid_word_chars

  def sanitize_word(word)
    word.downcase.gsub(/^['"]|['"]$/,'')
  end
end
