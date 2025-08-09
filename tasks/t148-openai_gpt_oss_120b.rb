def bf(planet1, planet2)
  planets = %w[Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune]
  i1 = planets.index(planet1)
  i2 = planets.index(planet2)
  return [] if i1.nil? || i2.nil?
  start_idx = [i1, i2].min
  end_idx = [i1, i2].max
  planets[(start_idx + 1)...end_idx] || []
end