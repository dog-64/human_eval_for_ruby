def bf(planet1, planet2)
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
  index1 = planets.index(planet1)
  index2 = planets.index(planet2)
  return [] if index1.nil? || index2.nil?

  start, finish = [index1, index2].minmax
  planets[(start + 1)...finish]
end