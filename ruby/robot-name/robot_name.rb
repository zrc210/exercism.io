module BookKeeping
  VERSION = 2
end

class NameGenerator
  def initialize
    srand
  end

  def name
    prefix + digits
  end

  private

  ALPHABET = [*'A'..'Z'].freeze

  def prefix
    2.times.reduce('') { |prefix| prefix << ALPHABET[rand(26)] }
  end

  def digits
    3.times.reduce('') { |digits| digits << rand(10).to_s }
  end
end

class Robot
  def initialize(name_generator = NameGenerator.new)
    @name_generator = name_generator
  end

  def reset
    @name = nil
  end

  def name
    @name ||= name_generator.name
  end

  private

  attr_reader :name_generator
end
