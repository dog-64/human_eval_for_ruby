assert fib(1) == 1
assert fib(2) == 1
assert fib(8) == 21
assert fib(10) == 55
assert fib(15) == 610
assert fib(20) == 6765
assert_raises {fib(0)} #Обработка ошибки, n < 1
assert_raises {fib(-5)} #Обработка ошибки, n < 1
assert_raises {fib("abc")} #Обработка ошибки, не число
assert_raises {fib([])} #Обработка ошибки, не число
assert_raises {fib({})} #Обработка ошибки, не число

