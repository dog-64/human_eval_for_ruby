def compare_one(a, b)
  if a.is_a?(Integer) && b.is_a?(Integer)
    a > b ? a : (a == b ? nil : b)
  elsif a.is_a?(Float) && b.is_a?(Float)
    a > b ? a : (a == b ? nil : b)
  elsif a.is_a?(String) && b.is_a?(String)
    begin
      a_float = Float(a.gsub(",", "."))
      b_float = Float(b.gsub(",", "."))
      a_float > b_float ? a : (a_float == b_float ? nil : b)
    rescue
      a == b ? nil : nil
    end
  elsif a.is_a?(Integer) && b.is_a?(String)
    begin
      b_float = Float(b.gsub(",", "."))
      a > b_float ? a : (a == b_float ? nil : b_float)
    rescue
      a == b ? nil : nil
    end
  elsif a.is_a?(String) && b.is_a?(Integer)
    begin
      a_float = Float(a.gsub(",", "."))
      a_float > b ? a_float : (a_float == b ? nil : b)
    rescue
      a == b ? nil : nil
    end
  elsif a.is_a?(Float) && b.is_a?(String)
    begin
      b_float = Float(b.gsub(",", "."))
      a > b_float ? a : (a == b_float ? nil : b_float)
    rescue
      a == b ? nil : nil
    end
  elsif a.is_a?(String) && b.is_a?(Float)
    begin
      a_float = Float(a.gsub(",", "."))
      a_float > b ? a_float : (a_float == b ? nil : b)
    rescue
      a == b ? nil : nil
    end
  else
    a == b ? nil : nil
  end
end
