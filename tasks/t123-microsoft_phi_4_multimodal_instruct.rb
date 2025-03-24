def get_odd_collatz(n)
  return [1] if n == 1
  collatz = [n]
  until collatz.last == 1
    collatz << collatz.last / 2 if collatz.last.even?
    collatz << 3 * collatz.last + 1 if collatz.last.odd?
  end
  collatz.reject! { |num| num.even? }
  collatz.sort
end