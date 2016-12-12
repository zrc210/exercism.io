module BookKeeping
  VERSION = 3
end

ENGLISH_ALPHABET = [*'a'..'z'].freeze

class Pangram
  def self.pangram?(string)
    new.pangram?(string)
  end

  def initialize(alphabet: ENGLISH_ALPHABET)
    @alphabet = alphabet
  end

  def pangram?(string)
    normalized = normalize(string)
    normalized.chars.uniq.length == alphabet.length
  end

  private

  attr_reader :alphabet

  def normalize(string)
    delete_range = format('^%s-%s', *alphabet.minmax)
    string.downcase.delete(delete_range)
  end
end
