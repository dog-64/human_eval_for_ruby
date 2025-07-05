def is_cube?(a)
  if a == 0
    return true
  end

  root = Math.sqrt(a)
  return root == Math.floor(root)
end
