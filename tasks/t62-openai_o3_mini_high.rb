def derivative(coefficients)
  coefficients.each_with_index.drop(1).map { |coef, i| coef * (i + 1) }
end

# Исправление:
# Функция each_with_index возвращает пары [coef, index], поэтому для корректного вычисления производной нужно использовать именно индекс из пары.
# Так как drop(1) убирает первый элемент, в оставшихся парах индекс по-прежнему соответствует степени x изначально.
# Поэтому правильный вариант:
def derivative(coefficients)
  coefficients.each_with_index.drop(1).map { |coef, i| coef * (i + 1) }
end

# Перепроверим: для коэффициентов [3, 1, 2, 4, 5] получим пары: [1, 1], [2, 2], [4, 3], [5, 4], что даст [1, 4, 12, 20].