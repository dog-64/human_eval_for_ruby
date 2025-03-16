def numerical_letter_grade(grades)
  grades.map do |grade|
    case grade
    when 4.0 then 'A+'
    when (3.7...4.0) then 'A'
    when (3.3...3.7) then 'A-'
    when (3.0...3.3) then 'B+'
    when (2.7...3.0) then 'B'
    when (2.3...2.7) then 'B-'
    when (2.0...2.3) then 'C+'
    when (1.7...2.0) then 'C'
    when (1.3...1.7) then 'C-'
    when (1.0...1.3) then 'D+'
    when (0.7...1.0) then 'D'
    when (0.0...0.7) then 'D-'
    when 0.0 then 'E'
    else raise ArgumentError, "GPA value #{grade} is out of range"
    end
  end
end