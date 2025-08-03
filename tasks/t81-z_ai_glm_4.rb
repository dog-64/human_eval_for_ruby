
_letter_grade(grades)
  grades.map do |grade|
    unless (0.0..4.0).include?(grade)
      raise ArgumentError, "Grade #{grade} is out of range [0.0, 4.0]"
    end

    if grade == 4.0
      "A+"
    elsif grade > 3.7
      "A"
    elsif grade > 3.3
      "A-"
    elsif grade >= 3.0
      "B+"
    elsif grade >= 2.5
      "B"
    elsif grade > 2.3
      "B-"
    elsif grade >= 2.0
      "C+"
    elsif grade >= 1.7
      "C"
    elsif grade >= 1.2
      "C-"
    elsif grade >= 1.0
      "D+"
    elsif grade >= 0.7
      "D"
    elsif grade > 0.0
      "D-"
    else
      "E"
    end
  end
end