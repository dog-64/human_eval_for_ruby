def truncate_number(number)
  (number * 10**10).to_i.to_f / 10**10
end