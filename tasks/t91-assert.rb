assert count_boredoms("Hello world") == 0
assert count_boredoms("The sky is blue. The sun is shining. I love this weather!") == 1
assert count_boredoms("I am bored. I am tired. Are you bored too?") == 2
assert count_boredoms("i am not bored. I am happy!") == 1
assert count_boredoms("") == 0
assert count_boredoms("I.I.I.") == 3
assert count_boredoms("I am happy!. I am great?") == 2
assert count_boredoms("I am happy! I am great.") == 2
assert count_boredoms("Some text. I am here. More text!") == 1
assert count_boredoms("No I'm not. I am.") == 2
assert count_boredoms("I") == 1
assert count_boredoms("I.") == 1
assert count_boredoms("I!") == 1
assert count_boredoms("I?") == 1
assert count_boredoms("..I...") == 1

