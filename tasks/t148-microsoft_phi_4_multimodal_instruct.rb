def bf(planet1, planet2)
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
  return [] unless planets.include?(planet1) && planets.include?(planet2)
  index1, index2 = planets.index(planet1), planets.index(planet2)
  planets[(index1 < index2) ? index1 + 1 : index2 - 1..index2].sort!
end
