def match_parens(lst)
  def balanced?(s)
    count = 0
    s.each_char do |ch|
      count += ch == '(' ? 1 : -1
      return false if count < 0
    end
    count.zero?
  end

  [lst[0] + lst[1], lst[1] + lst[0]].each { |s| return 'Yes' if balanced?(s) }
  'No'
end