PLANETS = %w[Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune].freeze

def bf(planet1, planet2)
  return [] unless PLANETS.include?(planet1) && PLANETS.include?(planet2)
  idx1 = PLANETS.index(planet1)
  idx2 = PLANETS.index(planet2)
  return [] if idx1 == idx2
  start, finish = [idx1, idx2].min, [idx1, idx2].max
  PLANETS[(start + 1)..(finish - 1)] || []
end