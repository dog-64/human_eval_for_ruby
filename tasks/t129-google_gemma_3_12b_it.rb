def min_path(grid, k)
  n = grid.length
  
  def find_paths(current_path, current_row, current_col)
    if current_path.length == k
      return [current_path]
    end
    
    paths = []
    
    # Possible moves: up, down, left, right
    moves = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    
    moves.each do |dr, dc|
      new_row = current_row + dr
      new_col = current_col + dc
      
      if new_row >= 0 && new_row < n && new_col >= 0 && new_col < n
        new_path = current_path + [grid[new_row][new_col]]
        paths += find_paths(new_path, new_row, new_col)
      end
    end
    
    return paths
  end
  
  all_paths = []
  
  (0...n).each do |i|
    (0...n).each do |j|
      all_paths += find_paths([grid[i][j]], i, j)
    end
  end
  
  min_lexicographical_path = all_paths.min
  
  return min_lexicographical_path
end
