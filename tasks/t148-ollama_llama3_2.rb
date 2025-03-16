def bf(planet1, planet2)
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
  idx1 = planets.index(planet1)
  idx2 = planets.index(planet2)

  return [] if idx1.nil? || idx2.nil?

  (idx1 + 1..idx2).map { |i| planets[i] }
end