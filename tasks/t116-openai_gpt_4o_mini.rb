def sort_array(arr)
  arr.select(&:nonnegative?).sort_by { |n| [n.to_s(2).count('1'), n] }
end

class Integer
  def nonnegative?
    self >= 0
  end
end