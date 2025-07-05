def min_path(grid, k)
  n = grid.length
  min_path_found = nil
  
  (0...n).each do |start_row|
    (0...n).each do |start_col|
      
      queue = [[grid[start_row][start_col], [[start_row, start_col]]]]
      
      while !queue.empty?
        current_val, current_path = queue.shift
        
        if current_path.length == k
          if min_path_found.nil? || current_val < min_path_found.first
            min_path_found = current_val
          end
          next
        end
        
        last_row, last_col = current_path.last
        
        [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dr, dc|
          new_row, new_col = last_row + dr, last_col + dc
          
          if new_row >= 0 && new_row < n && new_col >= 0 && new_col < n
            new_path = current_path + [[new_row, new_col]]
            new_val = current_val.dup
            new_val << grid[new_row][new_col]
            
            queue << [new_val, new_path]
            queue.sort_by! { |val, path| val }
          end
        end
      end
    end
  end
  
  min_path_found
end