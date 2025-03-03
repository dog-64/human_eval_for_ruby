assert histogram('a b c') == {'a'=>1, 'b'=>1, 'c'=>1}
assert histogram('a b b a') == {'a'=>2, 'b'=>2}
assert histogram('a b c a b') == {'a'=>2, 'b'=>2}
assert histogram('b b b b a') == {'b'=>4}
assert histogram('') == {}
assert histogram('a b c d a b c d e') == {'a'=>2, 'b'=>2, 'c'=>2, 'd'=>2}
assert histogram('a') == {'a'=>1}
assert histogram('bbbbb') == {'b'=>5}
assert histogram('a a a b b c') == {'a'=>3, 'b'=>2}
assert histogram('aBcDeF') == {'a'=>1, 'b'=>1, 'c'=>1, 'd'=>1, 'e'=>1, 'f'=>1}
assert histogram('1 2 3') == {}
assert histogram('  ') == {}
assert histogram('a b c d e f g h i j k l m n o p q r s t u v w x y z') == {'a'=>1, 'b'=>1, 'c'=>1, 'd'=>1, 'e'=>1, 'f'=>1, 'g'=>1, 'h'=>1, 'i'=>1, 'j'=>1, 'k'=>1, 'l'=>1, 'm'=>1, 'n'=>1, 'o'=>1, 'p'=>1, 'q'=>1, 'r'=>1, 's'=>1, 't'=>1, 'u'=>1, 'v'=>1, 'w'=>1, 'x'=>1, 'y'=>1, 'z'=>1}

