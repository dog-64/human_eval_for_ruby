assert numerical_letter_grade([4.0, 3.0, 1.7, 2.0, 3.5]) == ["A+", "B+", "C", "C+", "A-"]
assert numerical_letter_grade([3.8, 2.5, 1.2, 0.0, 0.9]) == ["A", "B", "C-", "E", "D"]
assert numerical_letter_grade([4.0]) == ["A+"]
assert numerical_letter_grade([0.0]) == ["E"]
assert numerical_letter_grade([3.7]) == ["A"]
assert numerical_letter_grade([3.3]) == ["A-"]
assert numerical_letter_grade([2.7]) == ["B"]
assert numerical_letter_grade([2.3]) == ["B-"]
assert numerical_letter_grade([2.0]) == ["C+"]
assert numerical_letter_grade([1.7]) == ["C"]
assert numerical_letter_grade([1.3]) == ["C-"]
assert numerical_letter_grade([1.0]) == ["D+"]
assert numerical_letter_grade([0.7]) == ["D"]
assert_raises(ArgumentError) { numerical_letter_grade("string") }
assert_raises(ArgumentError) { numerical_letter_grade([]) }
assert_raises(ArgumentError) { numerical_letter_grade([4.1]) }
assert_raises(ArgumentError) { numerical_letter_grade([-0.1]) }
assert_raises(ArgumentError) { numerical_letter_grade([1, "a"]) }

