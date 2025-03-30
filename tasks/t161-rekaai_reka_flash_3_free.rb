
def solve(s)
  has_letters = s.chars.any? { |c| c.letter? }
  transformed = s.chars.map { |c| c.letter? ? c.toggle_case : c }
  has_letters ? transformed.join : s.reverse
end

 