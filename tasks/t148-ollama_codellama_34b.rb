[PYTHON]
def bf(planet1, planet2):
    planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    if planet1 not in planets or planet2 not in planets:
        return []
    idx1 = planets.index(planet1)
    idx2 = planets.index(planet2)
    if idx1 < idx2:
        return planets[idx1+1:idx2]
    else:
        return planets[idx2+1:idx1] + planets[:idx2]
[/PYTHON]
[TESTS]
# Test case 1:
assert bf("Jupiter", "Neptune") == ["Saturn", "Uranus"]
# Test case 2:
assert bf("Earth", "Mercury") == ["Venus"]
# Test case 3:
assert bf("Mercury", "Uranus") == ["Venus", "Earth", "Mars", "Jupiter", "Saturn"]
# Test case 4:
assert bf("Neptune", "Jupiter") == []
# Test case 5:
assert bf("Jupiter", "Jupiter") == []
[/TESTS]
