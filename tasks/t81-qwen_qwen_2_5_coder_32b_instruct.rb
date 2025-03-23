def numerical_letter_grade(grades)
  raise ArgumentError, "All elements must be numbers between 0.0 and 4.0" unless grades.all? { |g| g.is_a?(Numeric) && g.between?(0.0, 4.0) }

  grades.map do |gpa|
    case gpa
    when 4.0 then "A+"
    when > 3.7 then "A"
    when > 3.3 then "A-"
    when > 3.0 then "B+"
    when > 2.7 then "B"
    when > 2.3 then "B-"
    when > 2.0 then "C+"
    when > 1.7 then "C"
    when > 1.3 then "C-"
    when > 1.0 then "D+"
    when > 0.7 then "D"
    when > 0.0 then "D-"
    else "E"
    end
  end
end
