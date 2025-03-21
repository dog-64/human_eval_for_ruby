def bf(planet1, planet2)
  # Определяем порядок планет от Солнца
  planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

  # Определяем индексы планет в массиве
  planet1_index = planets.index(planet1)
  planet2_index = planets.index(planet2)

  # Если хотя бы одно из названий планет некорректно, возвращаем пустой массив
  return [] if planet1_index.nil? || planet2_index.nil?

  # Определяем ближайшую планету к Солнцу
  closest_planet = planets[0]

  # Определяем планеты, которые находятся между орбитами planet1 и planet2
  between_planets = []
  (planet1_index..planet2_index).each do |i|
    between_planets << planets[i] if i != 0 && i != 7
  end

  # Возвращаем планеты, расположенные между орбитами planet1 и planet2
  return between_planets
end