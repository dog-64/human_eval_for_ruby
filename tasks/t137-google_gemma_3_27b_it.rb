def compare_one(a, b)
  a_val = case a
          when String
            begin
              Float(a.gsub(',', '.'))
            rescue ArgumentError
              nil
            end
          else
            a
          end

  b_val = case b
          when String
            begin
              Float(b.gsub(',', '.'))
            rescue ArgumentError
              nil
            end
          else
            b
          end

  if a_val.nil? || b_val.nil?
    return nil
  end

  if a_val > b_val
    a
  elsif b_val > a_val
    b
  else
    nil
  end
end