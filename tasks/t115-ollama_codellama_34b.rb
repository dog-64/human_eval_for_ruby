def max_fill(grid, capacity)
    # Calculate the total amount of water in the wells
    total_water = grid.flatten.sum

    # Calculate the number of buckets needed to remove all the water
    num_buckets = (total_water / capacity).ceil

    # Return the number of buckets needed
    return num_buckets
end