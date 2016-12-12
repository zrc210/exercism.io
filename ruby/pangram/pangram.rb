module BookKeeping
  VERSION = 3
end
module Pangram
  ENGLISH_ALPHABET = [*'a'..'z'].freeze
  class << self
    def pangram?(string, alphabet = ENGLISH_ALPHABET)
      normalized = normalize(string, alphabet)
      normalized.chars.uniq.length == alphabet.length
    end

    private

    def normalize(string, alphabet)
      delete_range = format('^%s-%s', *alphabet.minmax)
      string.downcase.delete(delete_range)
    end
  end
end
