def bf(planet1, planet2)
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

  if !planets.include?(planet1) || !planets.include?(planet2)
    return []
  end

  start_index = planets.index(planet1)
  end_index = planets.index(planet2)

  if start_index > end_index
    start_index, end_index = end_index, start_index
  end

  planets[start_index + 1..end_index - 1]
end