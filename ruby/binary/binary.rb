module BookKeeping
  VERSION = 3
end

module Binary
  BASE = 2
  class << self
    def to_decimal(binary_string)
      raise ArgumentError unless %r{^[0-1]+$} =~ binary_string
      # binary_string.to_i(2) # :)
      # reading left to right
      # 2**n + 2**(n-1) + ... + 2**(0)
      exponent = binary_string.length - 1
      binary_string
        .chars
        .reduce(0) do |sum, flag|
          sum += (BASE ** exponent) * flag.to_i
          exponent -= 1
          sum
      end
    end
  end
end
