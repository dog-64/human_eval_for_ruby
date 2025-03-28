def bf(planet1, planet2)
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
  planet1_index = planets.index(planet1)
  planet2_index = planets.index(planet2)

  if planet1_index.nil? || planet2_index.nil?
    return []
  end

  if planet1_index > planet2_index
    planet1_index, planet2_index = planet2_index, planet1_index
  end

  planets[planet1_index + 1..planet2_index - 1].map(&:to_s)
end