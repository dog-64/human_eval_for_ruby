assert split_words("Hello world!") == ["Hello", "world!"]
assert split_words("Hello,world!") == ["Hello", "world!"]
assert split_words("abcdef") == 3
assert split_words("A") == 0
assert split_words("") == 0
assert split_words("aBcDeF") == 3
assert split_words("Hello, world,!") == ["Hello", "world", "!"]
assert split_words("  Hello  world  !") == ["Hello", "world", "!"]
assert split_words(",Hello,,world,,!") == ["Hello", "world", "!"]
assert split_words("a,b,c,d,e,f") == ["a", "b", "c", "d", "e", "f"]
assert split_words("12345") == 0
assert split_words("!@#$%^") == 0
assert split_words("aBcDeFgHiJkLmNoP") == 11
assert split_words("  ") == []
assert split_words(",") == []
assert split_words("abc def ghi") == ["abc", "def", "ghi"]

