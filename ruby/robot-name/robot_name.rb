require 'set'

module BookKeeping
  VERSION = 2
end

class Database
  def initialize
    @storage = Set.new
  end

  def add(name)
    storage.add(name)
    self
  end

  def delete(name)
    storage.delete(name)
    self
  end

  def exists?(name)
    storage.include?(name)
  end

  private

  attr_reader :storage
end

class NameGenerator
  ALPHABET = [*'A'..'Z'].freeze
  private_constant :ALPHABET

  def initialize(randomizer: Random.new, database: Database.new)
    @randomizer = randomizer
    @database = database
  end

  def generate(old_name = nil)
    database.delete(old_name) unless old_name
    generated = name
    generated = name while database.exists?(generated)
    database.add(generated)
    generated
  end

  private

  attr_reader :randomizer, :database

  def name
    prefix + digits
  end

  def prefix
    2.times.reduce('') { |prefix| prefix << ALPHABET[rand(ALPHABET.length)] }
  end

  def digits
    format('%03i', rand(1000))
  end

  def rand(max)
    randomizer.rand(max)
  end
end

class Robot
  def initialize(name_generator: NameGenerator.new)
    @name_generator = name_generator
  end

  def reset
    @name = nil
  end

  def name
    @name ||= name_generator.generate(@name)
  end

  private

  attr_reader :name_generator
end
