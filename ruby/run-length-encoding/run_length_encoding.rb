module BookKeeping
  VERSION = 2
end
module RunLengthEncoding
  class << self
    def encode(input)
      input
        .chars
        .chunk(&:to_s)
        .map { |char, array| format_length(array.length) + char }
        .join
    end
    def decode(input)
      input
        .scan(/(\d+)?(.)/)
        .map {|count, char| char * parse_count(count.to_i)}
        .join
    end

    private

    def format_length(length)
      return '' unless length > 1
      length.to_s
    end

    def parse_count(count)
      [1,count].max
    end
  end
end
