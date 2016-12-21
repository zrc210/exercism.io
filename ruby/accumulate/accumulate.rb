module BookKeeping
  VERSION = 1
end

class Array
  def accumulate
    outputs = []
    self.each do |element|
      outputs << yield(element)
    end
    outputs
  end
end
