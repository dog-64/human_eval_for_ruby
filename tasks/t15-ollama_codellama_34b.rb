
def string_sequence(n)
    return "0" if n == 0
    (1..n).map(&:to_s).join(" ")
end