def count_upper(s)
  count = 0
  first_upper_index = nil
  
  # Находим индекс первой заглавной буквы
  s.each_char.with_index do |c, i|
    if c >= 'A' && c <= 'Z'
      first_upper_index = i
      break
    end
  end
  
  # Если первая заглавная буква на нечетном индексе, возвращаем 0
  return 0 if first_upper_index && first_upper_index.odd?
  
  # Иначе считаем все заглавные буквы на четных индексах
  s.each_char.with_index do |c, i|
    is_upper = c >= 'A' && c <= 'Z'
    puts "Index #{i} (#{i.even? ? 'even' : 'odd'}): '#{c}' is #{is_upper ? 'upper' : 'lower'}"
    count += 1 if i.even? && is_upper
  end
  
  puts "Final count: #{count}"
  count
end 