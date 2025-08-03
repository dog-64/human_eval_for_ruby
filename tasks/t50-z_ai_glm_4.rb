
def decode_shift(s)
  s.chars.map do |c|
    # Получаем код символа, вычитаем код 'a', сдвигаем на 5 назад, берем модуль 26, добавляем код 'a'
    ((c.ord - 'a'.ord - 5) % 26 + 'a'.ord).chr
  end.join
end