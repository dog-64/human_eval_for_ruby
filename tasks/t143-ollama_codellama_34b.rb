[PYTHON]
def prime_length_words(sentence):
    words = sentence.split()
    prime_words = []
    for word in words:
        if is_prime(len(word)):
            prime_words.append(word)
    return " ".join(prime_words)

def is_prime(n):
    if n == 1:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True
[/PYTHON]
[TESTS]
# Test case 1:
assert prime_length_words("This is a test") == "is"
# Test case 2:
assert prime_length_words("lets go for swimming") == "go for"
# Test case 3:
assert prime_length_words("a") == ""
# Test case 4:
assert prime_length_words("one two three") == "two"
[/TESTS]
