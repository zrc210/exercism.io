module ETL
  class << self
    def transform(old)
      pairs = old.flat_map do |score, letters|
        letters.map { |letter| [letter.downcase, score] }
      end
      pairs.to_h
    end
  end
end
