def bf(planet1, planet2)
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
  
  index1 = planets.index(planet1)
  index2 = planets.index(planet2)
  
  return [] if index1.nil? || index2.nil?
  
  if index1 < index2
    planets[index1+1...index2]
  else
    planets[index2+1...index1]
  end
end