
def get_odd_collatz(n)
  result = [1]
  result << n if n.odd?
  result.uniq.sort
end