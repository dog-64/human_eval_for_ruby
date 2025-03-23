
def below_threshold(numbers, threshold)
  numbers.all? { |number| number < threshold }
end
