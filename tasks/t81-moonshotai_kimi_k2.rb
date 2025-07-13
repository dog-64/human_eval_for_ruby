def numerical_letter_grade(grades)
  grades.map do |grade|
    case grade
    when 4.0 then "A+"
    when ->(g) { g > 3.7 } then "A"
    when ->(g) { g > 3.3 } then "A-"
    when ->(g) { g > 3.0 } then "B+"
    when ->(g) { g > 2.7 } then "B"
    when ->(g) { g > 2.3 } then "B-"
    when ->(g) { g > 2.0 } then "C+"
    when ->(g) { g > 1.7 } then "C"
    when ->(g) { g > 1.3 } then "C-"
    when ->(g) { g > 1.0 } then "D+"
    when ->(g) { g > 0.7 } then "D"
    when ->(g) { g > 0.0 } then "D-"
    else "E"
    end
  end
end