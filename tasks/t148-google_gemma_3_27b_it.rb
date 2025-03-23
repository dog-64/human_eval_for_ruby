def bf(planet1, planet2)
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
  
  idx1 = planets.index(planet1)
  idx2 = planets.index(planet2)

  if idx1.nil? || idx2.nil?
    return []
  end

  start_idx = [idx1, idx2].min
  end_idx = [idx1, idx2].max

  result = []
  (start_idx + 1).upto(end_idx - 1) do |i|
    result << planets[i]
  end

  return result
end