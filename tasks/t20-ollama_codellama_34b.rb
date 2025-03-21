[PYTHON]
def find_closest_elements(numbers):
    numbers.sort()
    closest_elements = []
    for i in range(len(numbers)):
        if len(closest_elements) == 2:
            break
        if i == len(numbers) - 1 or numbers[i] != numbers[i + 1]:
            closest_elements.append(numbers[i])
    return tuple(closest_elements)
[/PYTHON]
