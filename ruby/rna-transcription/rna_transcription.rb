module BookKeeping
  VERSION = 4
end

module Complement
  class << self
    LOOKUP = {
      'G' => 'C',
      'C' => 'G',
      'T' => 'A',
      'A' => 'U'
    }
    def of_dna(dna)
      rna = [*0...dna.length]
              .map { |i| LOOKUP[dna[i]] }
              .compact
              .join('')
      return '' if rna.length != dna.length
      rna
    end
  end
end
