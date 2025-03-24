def numerical_letter_grade(grades)
  grade_mapping = {
    'A+' => 4.0, 'A' => 3.7..4.0, 'A-' => 3.3..3.7,
    'B+' => 2.7..3.3, 'B' => 2.3..2.7, 'B-' => 2.0..2.3,
    'C+' => 1.7..2.0, 'C' => 1.3..1.7, 'C-' => 1.0..1.3,
    'D+' => 0.7..1.0, 'D' => 0.0..0.7, 'D-' => 0.0, 'E' => 0.0
  }

  grades.map do |grade|
    grade_mapping.each do |letter_grade, range|
      if range.include?(grade)
        return letter_grade
      end
    end
    raise ArgumentError, "Invalid GPA value: #{grade}"
  end
end