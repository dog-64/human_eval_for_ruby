
пишите функцию `make_a_pile(n)`, которая моделирует создание каменной пирамиды из `n` уровней."
  This clearly states `n````ruby
def make_a_pile(n)
  pile = []
  current_stones = n
  n.times do
    pile << current_stones
