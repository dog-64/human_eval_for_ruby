def numerical_letter_grade(grades)
  # Таблица соответствия GPA и буквенных оценок
  grade_map = {
    4.0 => "A+",
    (3.7..4.0) => "A",
    (3.3..3.7) => "A-",
    (3.0..3.3) => "B+",
    (2.7..3.0) => "B",
    (2.3..2.7) => "B-",
    (2.0..2.3) => "C+",
    (1.7..2.0) => "C",
    (1.3..1.7) => "C-",
    (1.0..1.3) => "D+",
    (0.7..1.0) => "D",
    0.0 => "E"
  }

  # Обработка некорректного ввода
  unless grades.all? { |grade| grade.is_a?(Float) && (0.0..4.0).cover?(grade) }
    raise ArgumentError, "Invalid input: all elements must be floats between 0.0 and 4.0"
  end

  # Преобразование GPA в буквенные оценки
  grades.map { |grade| grade_map[grade] || "E" }
end