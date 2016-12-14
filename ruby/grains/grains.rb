module Grains
  def self.square(index)
    GrainBoard.new.square(index)
  end

  def self.total
    GrainBoard.new.total
  end

  class GrainBoard
    def initialize(base: 2, max_squares: 64)
      raise(ArgumentError,
            "base must be greater than 1") unless base > 1
      raise(ArgumentError,
           "max_squares must be a positive integer") unless max_squares > 0
      @base = base
      @max_squares = max_squares
    end

    def square(requested_square)
      # the squares are indexed with a starting index of 1
      index = requested_square - 1
      raise(ArgumentError,
            "Square must be in [1,#{max_squares}]") unless in_bounds?(index)
      compute(index)
    end

    def total
      # the sum(n=0, N) b**n = (((b**(N+1)) - 1)/(b-1))
      (compute(max_squares) - 1) / (base - 1)
    end

    private

    attr_reader :max_squares, :base

    def compute(index)
      base**(index)
    end

    def in_bounds?(index)
      (0...max_squares).cover?(index)
    end
  end
end
