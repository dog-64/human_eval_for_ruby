assert string_to_md5('Hello world') == '3e25960a79dbc69b674cd4ec67a72c62'
assert string_to_md5('') == nil
assert string_to_md5('test') == '098f6bcd4621d373cade4e832627b4f6'
assert string_to_md5('1234567890') == '34aa973cd4c4daa2f85076c6c871cc9a'
assert string_to_md5('This is a longer string') == 'a665a45920422f9d417e4867efdc4fb8'
assert string_to_md5(' ') == 'c4ca4238a0b923820dcc509a6f75849b'
assert string_to_md5(123) == nil # проверяем обработку нестрокового аргумента
assert string_to_md5([]) == nil # проверяем обработку нестрокового аргумента
assert string_to_md5({}) == nil # проверяем обработку нестрокового аргумента

