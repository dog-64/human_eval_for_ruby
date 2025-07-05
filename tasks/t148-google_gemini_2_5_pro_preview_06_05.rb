

- `PLANETS[0 + 1...2]` -> `PLANETS[1...2]`
- This slice will be `["Venus"]`. Correct.

Let's trace
 an invalid case: `bf("Earth", "Pluto")`
- `index1 = PLANETS.index("Earth")` -> `2`
- `