module BookKeeping
  VERSION = 3
end

class Frame
  attr_reader :number, :rolls
  MIN_PINS = 0
  MAX_PINS = 10
  MAX_FRAMES = 10

  def initialize(number)
    @number = number
    @rolls = []
  end

  def roll(pins)
    rolls << pins
  end

  def strike?
    rolls.first == MAX_PINS
  end

  def spare?
    !strike? && rolls.first(2).inject(:+) == MAX_PINS
  end

  def open?
    !strike? && !spare? && rolls.length == 2
  end

  def total_pins
    rolls.inject(:+).to_i
  end

  def complete?
    if last?
      open? || rolls.length == 3
    else
      strike? || spare? || open?
    end
  end

  def last?
    number == MAX_FRAMES
  end

  def score(bonus_rolls)
    total_pins + score_bonus(bonus_rolls)
  end

  def valid_roll?(pins)
    (MIN_PINS..MAX_PINS).cover?(pins) &&
      rolls.count <= max_rolls &&
      valid_roll_in_frame?(pins)
  end

  private

  attr_writer :rolls

  def valid_roll_in_frame?(pins)
    if last? && (strike? || spare?)
      (rolls.last == MAX_PINS || spare?) || rolls.last + pins <= MAX_PINS
    else
      total_pins + pins <= MAX_PINS
    end
  end

  def max_rolls
    return 3 if last? && (strike? || spare?)
    2
  end

  def score_bonus(bonus_rolls)
    number_of_bonus_rolls = if strike?
                              2
                            elsif spare?
                              1
                            else
                              0
                            end
    bonus_rolls
      .first(number_of_bonus_rolls)
      .inject(:+).to_i
  end
end

class Game
  class BowlingError < StandardError; end
  MIN_PINS = 0
  MAX_PINS = 10

  def initialize
    @frames = Array.new(10) { |number| Frame.new(number + 1) }
    @current_frame_index = 0
  end

  def roll(pins)
    validate(pins)
    current_frame.roll(pins)
    increment_frame_number if current_frame.complete? &&
                              current_frame_index < frames.length - 1
  end

  def score
    raise BowlingError unless game_complete?
    frames.each_with_index.reduce(0) do |score, frame_pair|
      frame, frame_number = frame_pair
      score += frame.score(gather_bonus_rolls(frame_number))
      score
    end
  end

  private

  attr_accessor :current_frame_index
  attr_reader :frames

  def increment_frame_number
    @current_frame_index += 1
  end

  def validate(pins)
    raise BowlingError if game_complete? || !current_frame.valid_roll?(pins)
  end

  def current_frame
    frames[current_frame_index]
  end

  def game_complete?
    current_frame.last? && current_frame.complete?
  end

  def gather_bonus_rolls(frame_number)
    frames[frame_number + 1..frame_number + 2]
      .compact
      .map(&:rolls)
      .flatten
      .compact
  end
end
