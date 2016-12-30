module BookKeeping
  VERSION = 2
end

module BottleFactory
  class << self
    def for(number)
      bottle_klass = if number.zero?
                       BottleNumberZero
                     elsif number == 1
                       BottleNumberOne
                     else
                       BottleNumber
                     end
      bottle_klass.new(number: number, bottle_factory: self)
    end
  end
end

class BottleNumber
  def initialize(number:, bottle_factory: BottleFactory)
    @number = number
    @bottle_factory = bottle_factory
  end

  def container
    'bottles'
  end

  def action
    'Take one down and pass it around'
  end

  def quantity
    number
  end

  def successor_number
    number - 1
  end

  def successor_bottle
    bottle_factory.for(successor_number)
  end

  def to_s
    "#{quantity} #{container} of beer"
  end

  private

  attr_reader :number, :bottle_factory
end

class BottleNumberOne < BottleNumber
  def container
    'bottle'
  end

  def action
    'Take it down and pass it around'
  end
end

class BottleNumberZero < BottleNumber
  def container
    'bottles'
  end

  def action
    'Go to the store and buy some more'
  end

  def quantity
    'no more'
  end

  def successor_number
    99
  end
end

class BeerSong
  def initialize(bottle_factory: BottleFactory)
    @bottle_factory = bottle_factory
  end

  def verse(number)
    bottle = bottle_factory.for(number)
    successor = bottle.successor_bottle
    [
      "#{bottle.to_s.capitalize} on the wall, #{bottle}.",
      "#{bottle.action}, #{successor} on the wall.",
      ''
    ].join("\n")
  end

  def verses(starting, ending)
    starting
      .downto(ending)
      .map { |number| verse(number) }
      .join("\n")
  end

  def lyrics
    verses(99, 0)
  end

  private

  attr_reader :bottle_factory
end
