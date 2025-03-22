assert strongest_extension('Slices', ['SErviNGSliCes', 'Cheese', 'StuFfed']) == 'Slices.SErviNGSliCes'
assert strongest_extension('my_class', ['AA', 'Be', 'CC']) == 'my_class.AA'
assert strongest_extension('Example', ['a', 'b', 'c']) == 'Example.a'
assert strongest_extension('Test', []) == nil
assert strongest_extension('Class', ['ABC', 'abc', 'ABc']) == 'Class.ABC'
assert strongest_extension('AnotherClass', ['aBcDeFg', 'AbCdEfG']) == 'AnotherClass.AbCdEfG'
assert strongest_extension('Test', ['']) == 'Test.'
assert strongest_extension('Test', ['123', '456']) == 'Test.123'
