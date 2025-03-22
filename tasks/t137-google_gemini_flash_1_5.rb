def compare_one(a, b)
  a_num = begin
            Float(a.to_s.gsub(',', '.'))
          rescue
            a
          end
  b_num = begin
            Float(b.to_s.gsub(',', '.'))
          rescue
            b
          end

  if a_num == b_num
    nil
  elsif a_num > b_num
    a
  else
    b
  end
end
