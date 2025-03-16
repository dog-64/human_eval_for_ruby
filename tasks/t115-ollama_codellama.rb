def max_fill(grid, capacity)
    rows = grid.length
    cols = grid[0].length
    visited = Array.new(rows, Array.new(cols, false))
    count = 0
    
    (0..rows-1).each do |i|
        (0..cols-1).each do |j|
            if grid[i][j] == 1 && !visited[i][j]
                count += 1
                dfs(grid, i, j, visited, capacity)
            end
        end
    end
    
    return count
end

def dfs(grid, i, j, visited, capacity)
    rows = grid.length
    cols = grid[0].length
    if i < 0 || i >= rows || j < 0 || j >= cols || grid[i][j] == 0 || visited[i][j]
        return
    end
    
    visited[i][j] = true
    
    if grid[i][j] > capacity
        dfs(grid, i-1, j, visited, capacity)
        dfs(grid, i+1, j, visited, capacity)
        dfs(grid, i, j-1, visited, capacity)
        dfs(grid, i, j+1, visited, capacity)
    end
end