[PYTHON]
def count_boredoms(text):
    count = 0
    for sentence in text.split(".")[:-1]:
        if sentence.startswith("I"):
            count += 1
    return count
[/PYTHON]
[TESTS]
# Test case 1:
assert count_boredoms("Hello world") == 0
# Test case 2:
assert count_boredoms("The sky is blue. The sun is shining. I love this weather!") == 1
# Test case 3:
assert count_boredoms("I am bored. I am tired.  Are you bored too?") == 2
# Test case 4:
assert count_boredoms("i am not bored. I am happy!") == 1
# Test case 5:
assert count_boredoms("") == 0
# Test case 6:
assert count_boredoms("I.I.I.") == 3
[/TESTS]
