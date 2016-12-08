module BookKeeping
  VERSION = 3
end
module Pangram
  class << self
    def pangram?(str)
      str.downcase.delete('^a-z').chars.uniq.length == 26
    end
  end
end
