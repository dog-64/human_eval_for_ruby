assert decode_shift("mjqqt") == "hello"
assert decode_shift("fgjjj") == "abcd"
assert decode_shift("") == ""
assert decode_shift("abcdef") == "uvwxyz"
assert decode_shift("xyzabc") == "stuvw"
assert decode_shift("a") == "v"
assert decode_shift("z") == "u"

