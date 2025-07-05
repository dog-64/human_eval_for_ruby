def is_cube?(a)
  return false if a.nil?
  root = (a.abs**(1.0/3.0)).round
  if a < 0
    -root * -root * -root == a
  else
    root * root * root == a
  end
end