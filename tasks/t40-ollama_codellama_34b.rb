[PYTHON]
def triples_sum_to_zero(numbers):
    for i in range(len(numbers)):
        for j in range(i+1, len(numbers)):
            for k in range(j+1, len(numbers)):
                if numbers[i] + numbers[j] + numbers[k] == 0:
                    return True
    return False
[/PYTHON]
