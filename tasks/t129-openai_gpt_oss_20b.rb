def min_path(grid, k)
  n = grid.size
  heap = MinHeap.new
  visited = {}
  (0...n).each do |i|
    (0...n).each do |j|
      seq = [grid[i][j]]
      key = [i, j, 1]
      visited[key] = seq
      heap.push([seq, i, j, 1])
    end
  end
  dirs = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  until heap.empty?
    seq, i, j, l = heap.pop
    key = [i, j, l]
    next if visited[key] != seq
    return seq if l == k
    dirs.each do |di, dj|
      ni = i + di
      nj = j + dj
      next if ni < 0 || ni >= n || nj < 0 || nj >= n
      new_seq = seq + [grid[ni][nj]]
      new_l = l + 1
      new_key = [ni, nj, new_l]
      if !visited.key?(new_key) || new_seq < visited[new_key]
        visited[new_key] = new_seq
        heap.push([new_seq, ni, nj, new_l])
      end
    end
  end
  []
end

class MinHeap
  def initialize
    @data = []
  end

  def push(item)
    @data << item
    sift_up(@data.size - 1)
  end

  def pop
    return nil if @data.empty?
    min = @data[0]
    last = @data.pop
    unless @data.empty?
      @data[0] = last
      sift_down(0)
    end
    min
  end

  def empty?
    @data.empty?
  end

  private

  def sift_up(idx)
    while idx > 0
      parent = (idx - 1) / 2
      if @data[idx][0] < @data[parent][0]
        @data[idx], @data[parent] = @data[parent], @data[idx]
        idx = parent
      else
        break
      end
    end
  end

  def sift_down(idx)
    size = @data.size
    loop do
      left = idx * 2 + 1
      right = left + 1
      smallest = idx
      if left < size && @data[left][0] < @data[smallest][0]
        smallest = left
      end
      if right < size && @data[right][0] < @data[smallest][0]
        smallest = right
      end
      if smallest != idx
        @data[idx], @data[smallest] = @data[smallest], @data[idx]
        idx = smallest
      else
        break
      end
    end
  end
end