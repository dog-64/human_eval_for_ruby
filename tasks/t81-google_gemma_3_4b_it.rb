def numerical_letter_grade(grades)
  letter_grades = []
  grades.each do |grade|
    if grade > 4.0
      letter_grades << "A+"
    elsif grade > 3.7
      letter_grades << "A"
    elsif grade > 3.3
      letter_grades << "A-"
    elsif grade > 3.0
      letter_grades << "B+"
    elsif grade > 2.7
      letter_grades << "B"
    elsif grade > 2.3
      letter_grades << "B-"
    elsif grade > 2.0
      letter_grades << "C+"
    elsif grade > 1.7
      letter_grades << "C"
    elsif grade > 1.3
      letter_grades << "C-"
    elsif grade > 1.0
      letter_grades << "D+"
    elsif grade > 0.7
      letter_grades << "D"
    elsif grade > 0.0
      letter_grades << "D-"
    else
      letter_grades << "E"
    end
  end
  letter_grades
end
