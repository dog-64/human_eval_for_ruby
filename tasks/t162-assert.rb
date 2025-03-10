assert string_to_md5('Hello world') == '3e25960a79dbc69b674cd4ec67a72c62'
assert string_to_md5('') == nil
assert string_to_md5('test') == '098f6bcd4621d373cade4e832627b4f6'
assert string_to_md5('1234567890') == 'e807f1fcf82d132f9bb018ca6738a19f'
