def solve(s)
  letters = s.chars.select { |char| ('a'..'z').include?(char.downcase) }
  if letters.empty?
    s.reverse
  else
    s.chars.map do |char|
      if ('a'..'z').include?(char)
        char.upcase
      elsif ('A'..'Z').include?(char)
        char.downcase
      else
        char
      end
    end.join
  end
end