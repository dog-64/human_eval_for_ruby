
. The order is important.

6.  So, the final structure will be:
    ```ruby
    def numerical_letter_grade(grades)
      grades.map do |gpa|
        # if/elsif/The problem states: "Функция должна выдавать ошибку или обрабатывать некорректный ввод (например, список содержащий не числа или числа вне допустимого диапазона