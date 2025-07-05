
0
      operations.each do |op|
        balance += op
        partial_sums << balance
      end
      partial_sums.any? { |sum| sum < 
}
    ```
    This works, but it's inefficient because it builds a whole new array (`