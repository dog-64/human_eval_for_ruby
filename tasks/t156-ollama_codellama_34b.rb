
def int_to_mini_roman(number)
    # create a hash to map numbers to Roman numerals
    roman_numerals = {
        1 => "i",
        5 => "v",
        10 => "x",
        50 => "l",
        100 => "c",
        500 => "d",
        1000 => "m"
    }

    # convert the number to a string and split it into an array of digits
    digit_array = number.to_s.split("")

    # initialize an empty string to store the Roman numeral
    roman_numeral = ""

    # iterate over the digit array and build the Roman numeral
    digit_array.each do |digit|
        # if the digit is 0, skip it
        next if digit == "0"

        # get the corresponding Roman numeral for the digit
        roman_numeral += roman_numerals[digit.to_i]
    end

    return roman_numeral
end