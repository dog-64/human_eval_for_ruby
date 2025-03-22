def bf(planet1, planet2)
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
  
  if !planets.include?(planet1) || !planets.include?(planet2)
    return []
  end
  
  index1 = planets.index(planet1)
  index2 = planets.index(planet2)
  
  if index1 > index2
    index1, index2 = index2, index1
  end
  
  planets[index1 + 1...index2]
end