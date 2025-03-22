def min_path(grid, k)
    # Initialize the path with the first element of the grid
    path = [grid[0][0]]

    # Loop until the path has the desired length
    while path.length < k
        # Get the current cell and its neighbors
        cell = path[-1]
        neighbors = get_neighbors(cell, grid)

        # Find the neighbor with the smallest value that has not been visited yet
        next_cell = nil
        neighbors.each do |neighbor|
            if !path.include?(neighbor) && (next_cell.nil? || neighbor < next_cell)
                next_cell = neighbor
            end
        end

        # Add the next cell to the path
        path << next_cell
    end

    return path
end

def get_neighbors(cell, grid)
    # Get the row and column of the current cell
    row = cell[0]
    col = cell[1]

    # Get the rows and columns of the neighboring cells
    neighbors = []
    [[row-1, col], [row, col-1], [row, col+1], [row+1, col]].each do |neighbor|
        if neighbor[0] >= 0 && neighbor[0] < grid.length && neighbor[1] >= 0 && neighbor[1] < grid[0].length
            neighbors << grid[neighbor[0]][neighbor[1]]
        end
    end

    return neighbors
end