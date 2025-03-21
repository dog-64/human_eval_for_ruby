[PYTHON]
def rolling_max(numbers):
    if not numbers:
        return []
    max_value = float('-inf')
    result = []
    for num in numbers:
        if num > max_value:
            max_value = num
        result.append(max_value)
    return result
[/PYTHON]
