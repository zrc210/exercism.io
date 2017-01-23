class SpaceAge
  EARTH_YEAR = 31_557_600.0

  PLANET_PERIODS = {
    earth:   1.0        * EARTH_YEAR,
    mercury: 0.2408467  * EARTH_YEAR,
    venus:   0.61519726 * EARTH_YEAR,
    mars:    1.8808158  * EARTH_YEAR,
    jupiter: 11.862615  * EARTH_YEAR,
    saturn:  29.447498  * EARTH_YEAR,
    uranus:  84.016846  * EARTH_YEAR,
    neptune: 164.79132  * EARTH_YEAR
  }.freeze

  attr_reader :seconds

  def initialize(seconds, planet_orbits = PLANET_PERIODS)
    @seconds = seconds
    @planet_orbits = planet_orbits
  end

  private

  attr_reader :planet_orbits

  def method_parser(method_sym)
    preposition, planet = method_sym.to_s.split('_')
    [preposition, planet.to_sym]
  end

  def respond_to_missing?(method_sym, *arguments)
    preposition, planet = method_parser(method_sym)
    (preposition.casecmp('on').zero? &&
     planet_orbits.key?(planet) &&
     arguments.length.zero?) || super
  end

  def method_missing(method_sym, *arguments, &_)
    return super unless respond_to_missing?(method_sym, *arguments)
    planet = method_parser(method_sym).last
    on(planet)
  end

  def on(planet)
    orbit_period = planet_orbits[planet]
    seconds / orbit_period
  end
end
