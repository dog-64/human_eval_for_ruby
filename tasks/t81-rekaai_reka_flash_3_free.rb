
def numerical_letter_grade(grades)
  grades.each do |grade|
    unless grade.is_a?(Numeric) && grade.between?(0.0, 4.0)
      raise ArgumentError, "Invalid GPA value: #{grade}. Must be a number between 0.0 and 4.0."
    end
  end

  conditions = [
    [->(g) { g > 3.7 }, 'A'],
    [->(g) { g > 3.3 }, 'A-'],
    [->(g) { g > 3.0 }, 'B+'],
    [->(g) { g > 2.7 }, 'B'],
    [->(g) { g > 2.3 }, 'B-'],
    [->(g) { g > 2.0 }, 'C+'],
    [->(g) { g > 1.7 }, 'C'],
    [->(g) { g > 1.3 }, 'C-'],
    [->(g) { g > 1.0 }, 'D+'],
    [->(g) { g > 0.7 }, 'D'],
    [->(g) { g > 0.0 }, 'D-'],
    [->(g) { g == 0.0 }, 'E']
  ]

  grades.map { |gpa| conditions.find { |_, letter| _[0].call(gpa) }[1] }
end

 