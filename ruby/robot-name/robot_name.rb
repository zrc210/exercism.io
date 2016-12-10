module BookKeeping
  VERSION = 2
end

class Database
  def initialize
    @@storage ||= {}
  end

  def add(name)
    storage[name] = true
    nil
  end

  def remove(name)
    storage.delete(name)
    nil
  end

  def exists?(name)
    storage.key?(name)
  end

  private

  def storage
    @@storage
  end
end

class NameGenerator
  def initialize(randomizer: Random.new, database: Database.new)
    @randomizer = randomizer
    @database = database
  end

  def generate(old_name = nil)
    database.remove(old_name) unless old_name
    generated = name
    generated = name while database.exists?(generated)
    database.add(generated)
    generated
  end

  private

  def name
    prefix + digits
  end

  attr_reader :randomizer, :database

  ALPHABET = [*'A'..'Z'].freeze

  def prefix
    2.times.reduce('') { |prefix| prefix << ALPHABET[random(26)] }
  end

  def digits
    format('%03i', random(1000))
  end

  def random(max)
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
