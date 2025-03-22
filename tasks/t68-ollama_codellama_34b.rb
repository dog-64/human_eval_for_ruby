[PYTHON]
def pluck(arr):
    if not arr:
        return []
    even_numbers = [num for num in arr if num % 2 == 0]
    if not even_numbers:
        return []
    smallest_even_number = min(even_numbers)
    smallest_even_number_index = arr.index(smallest_even_number)
    return [smallest_even_number, smallest_even_number_index]
[/PYTHON]
