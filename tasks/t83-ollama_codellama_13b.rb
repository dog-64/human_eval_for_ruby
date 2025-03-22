def starts_one_ends(n)
  count = 0
  1.upto(10**n - 1) do |num|
    if num.to_s.start_with?("1") || num.to_s.end_with?("1")
      count += 1
    end
  end
  count
end