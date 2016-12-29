class Array
  def keep(&block)
    keep_or_discard(:keep, &block)
  end

  def discard(&block)
    keep_or_discard(:discard, &block)
  end

  private

  def keep_or_discard(type)
    return each unless block_given?
    each_with_object([]) do |element, array|
      result = yield(element)
      result = !result if type == :discard
      array.push(element) if result
      array
    end
  end
end
