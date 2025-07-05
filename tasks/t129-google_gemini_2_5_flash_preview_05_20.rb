def min_path(grid, k)
  n = grid.length
  min_path_found = nil

  (0...n).each do |r|
    (0...n).each do |c|
      q = [[grid[r][c], [[r, c]]]]

      until q.empty?
        current_value, current_path_coords = q.shift

        if current_path_coords.length == k
          current_path_values = current_path_coords.map { |pr, pc| grid[pr][pc] }
          if min_path_found.nil? || current_path_values < min_path_found
            min_path_found = current_path_values
          end
          next
        end

        last_r, last_c = current_path_coords.last
        
        neighbors = []
        [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dr, dc|
          nr, nc = last_r + dr, last_c + dc
          if nr >= 0 && nr < n && nc >= 0 && nc < n
            neighbors << [grid[nr][nc], [nr, nc]]
          end
        end
        
        neighbors.sort_by! { |val, _| val }

        neighbors.each do |neighbor_value, neighbor_coords|
          new_path_coords = current_path_coords + [neighbor_coords]
          q << [neighbor_value, new_path_coords]
        end
      end
    end
  end
  min_path_found
end