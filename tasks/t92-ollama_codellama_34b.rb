[PYTHON]
def any_int?(x, y, z):
    if x % 1 == 0 and y % 1 == 0 and z % 1 == 0:
        for i in (x, y, z):
            if x + y == z or x + z == y or y + z == x:
                return True
        return False
    else:
        return False
[/PYTHON]
