class Series
  def initialize(series)
    @series = series.chars.map(&:to_i)
  end

  def slices(number)
    raise ArgumentError if number > series.length
    series.each_cons(number).to_a
  end

  private

  attr_reader :series
end
