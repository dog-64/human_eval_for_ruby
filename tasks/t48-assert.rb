assert is_palindrome?("") == true
assert is_palindrome?("aba") == true
assert is_palindrome?("A man, a plan, a canal: Panama") == true
assert is_palindrome?("aaaaa") == true
assert is_palindrome?("zbcd") == false
assert is_palindrome?("race a car") == true
assert is_palindrome?("12321") == true
assert is_palindrome?("12345") == false
assert is_palindrome?("Madam") == true
assert is_palindrome?("No 'x' in Nixon") == true
assert is_palindrome?("Was it a car or a cat I saw?") == true
assert is_palindrome?("A Toyota") == false
assert is_palindrome?(nil) == false #Проверка на nil
assert is_palindrome?(123) == false #Проверка на не строку
assert is_palindrome?([1,2,3]) == false #Проверка на массив
assert is_palindrome?({}) == false #Проверка на хеш

