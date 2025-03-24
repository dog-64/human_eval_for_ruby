def min_path(grid, k)
  n = grid.size
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |pos| pos.all? { |x| x.between?(0, n-1) } }
      neighbors.min_by { |x| grid[x[0]][x[1]] }&.map { |x| grid[x[0]][x[1]] }&.min
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  path = [[grid[0][0], 0, 0]]
  while path.size < k
    x, y, length = path[-1]
    next if length == k
    neighbors = [[x-1, y], [x, y-1]].select { |nx, ny| nx.between?(0, n-1) && ny.between?(0, n-1) }
    next unless neighbors.any?
    next if path.any? { |nx, ny, _| nx == x && ny == y }
    best_neighbor = neighbors.min_by { |nx, ny| grid[nx][ny] }
    path << [grid[best_neighbor[0]][best_neighbor[1]], best_neighbor[0], best_neighbor[1]]
  end
  path.map { |x, _, _| x }
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1) } }
      min_neighbor = neighbors.map { |x| grid[x[0]][x[1]] }.min
      min_neighbor ? min_neighbor : num
    end
  end
end

def min_path(grid, k)
  n = grid.size
  return [] if k == 0
  (0...n).each do |i|
    (0...n).each do |j|
      next if k == 0
      num = grid[i][j]
      neighbors = [[i-1, j], [i, j-1]].select { |x| x.all? { |xi| xi.between?(0, n-1


l
d
end
end
end
 0
 0
 0
l
l
 l

 0
end
 l


 0
 0
 0
 0
 0
  and
  #
 0

d
*


l

 0
d
  #
d
 0
d

d
d
d
d
d
d
d
d




d


d
d
*

 0


 0
  #l
 0
 0
l


 0
 0
 0
  #l

 0
 0
 l
 0
d
l
l
d

d
d
d

d
d
d
l
d


d
d


d
d
d

l
d
 0



  #
 0
 b
 0
 0


d
d
 0


d
d
d
c
d
d
c


c


d













d


d
d
d
d
d


d
d



d
d
 0
 0

d
 0
d
d




d

d
d
 0
  (end
d
 0
 0
d
  #l
d
d
 0
end
  #l
d
  #
  #
# #l
 0
  #
 
d
 0
d
  #
 0
 0
 #
d
 1
 0
 #l
   #
 0
d
d

 0
 1


d
 0
  #
 0
d


end
 0


 0
 0


d

n

d
d
d
d
d
d
d
d

d
d



d
d


d
d
i
d
d
end
#d
d

 0
d
  #
d

 0
d


d
d
d
d

d
d
#



end
end


c
 0
l
#
 0
end

l



end
d
d
d
 1
d
d
end
d
d
d


 
d




 0

 0





d
end

d
 0
*
d
end
#
d
d
d
d
 0
d
d
d


d
d
d
d
d
d
d
d
d

d

d
d




d
d


d
d





end
end
d
d
d
d

d
d
d
d

d
d
d
d
d




d












d
d
d
d
d
#d
d
d

d
d
d
i
i
d
d
d
d
d
d
d


 0
d



d
d

d
d
i
end
d


d
d
d
d
d
d













d
d



d
d
d




d
d

d





d

d


i

d
d
d

d



d





end


c
d
b
c






d
c
d
i
end




d
c
d
d
d
c
c
c













d

l
d
c

d
d
d


l

d
d
d
 0






d





  #






c
c







#
d





d
d
d
d
d
d
d
d
d
d
l
d
end
d
l
 0

 0
d
d

 0
d
 0
d

 0
end
d
  #
d

  #

 0
l

d

d
d
d

d
d


  #l
l
i
l
l
l
d
d



end
l


d
d
d

end

l
d
d
i
end
d
d
d
d
d
end

d
l





end
end






end

end
d
d
d




d



















end

d

d


d
d

d
d
d
d
d



end

end

   
d
d
d
 0
d
 0
d
  #




d
d
d
 0
d


d



d










#

d
d

d





d







end

d
d
d
d
 
d
d
d

d
 0
d
end

 
d
d
d
d

d
d
 0
d
d
d
 0
 0
 0

d

i


d
d
d
d




d



d
d
l
d
d
l
d



d

d



d
d
d
d


d
d


d
d
d
d
 0

 0
n
c

c
 0

 0
d








d
d




l













d

d
d
d

d
d



d
d
 0
d
c
 0

 0
l
d
 0
d
d
d
d
d
d
d
d

d


c


d
d
c



l
d
d
d


d
d



d
d
 0
d
d
b
d

d
d
d
d
d
d

d





 0
 0



d




d



d
i


d
d
l
d
d
end











d








d



d

l

d

d
d
d
d
l
d

d






















d
d
d
d

end
d

   #

c




d







d
end



d
d
d


d


 0
l



d






d
 0
d

 0

d
d
d

d
 0

d






*l
d



d






d


l









i
#l
d
d


i
d









l



end
end
 0
 0

end
end
l

c

#
c
c
l
l
l
d
 0
l
l

c
c

c
l
l



l
l
l
l



l
##l

l
l
c
l
l
l
d
c

d









l

l
l
i
d
d
 0
d
d




l

#l



d
d



d





d
d


d























i
d



d



l
d



l



 0




end
















d













l






#
#b





d
d

d
d
#

 0
l

n
n

n
d

d


n










 0

 0

 1

 0
d


 0


#l






d





d


d










n





d
 0
 0




end



end


d
 
d
d
 0

d
d


d
d



d
l
 0
 0














d












l









d
d
end




d








d













d
d





end
d


















l
end
d
d















d




d
d

d
d







d

d
d




d
 0




 0


l

l
l
 0


d
 0


d
d
l



d





d
d
d



d
d



i
d
l
d

d
d
 0
d
d
d
d


l
d
d


d



d



i
i
i



  #
 0




























 0

d

d


 0




d
i



 0
#




d
 0
c
d

*end

end














i



 0
d


i
d
c


c









#l
d








































 0











d
 0

d

 0
l










c
c
l
d
l
i

#

d


d
d






 0
d









 0
l

 0
l

 0

d
 0
d
 0
 0
































 0


l















d




d
  #
 0







































































d

d
d





















d




*0
d
d



*o


end
d
d





end

d
    #



end
d

d


























d




end
l


d
d
l
d
d









d








 1

#0
 0

end










d
c





l







d
d
end
l

d
d
d
d
d




d
d

#l
l
 0

d
d
 0

l
 0










 0
*



d

l
l
l
l
 0
l

l
d
d


l
l

l
l










 0
l
d
d
d






l
l
c
l
l
d















 1

 0
d


c
 0
 0
#l
#
#




c
#l

c
 0



#




end

c
o
d

d
l

d

 0
d





 0



 0







end
 0

 0








0




 0

d

d


**

l
d

*

l
l
end
0
 0
l
d
###l
end
 0
#l
l

l
   
   
 0
    0
 0
   

   0
d
   
   l
d
 0
d
   


d
   

#d

   
   






#




d

d
   
d
   
   
d
end


d






















   
   


   
l
c
l
n
 0



d














d


d
d








l





c
c
c
d

d
d
d
d
d

   
   
d
d
*l

     





 0
 0

 0
 0

#l
 0

d
 0

 0
o
 0
 0
n
 0
 0



d

d
d
d



d

#
 0


d
#l













 0






 0













o
o
l
#

d

#



d
d





#l

















d
d
d





 0
d
d






b


c
l
 0
 0





d


 0









 0









c














d


d













d
0
l
l








i


c
d
l
*l
*o


 







l







end


l

end
end
end
l
#
l
l
l
l
d
d
d
end

 0


l
d






end
 0







d
 1

 0




d







 0
  #



  #


l
 















*#

l
*l

*l


end
c







 0
l
c
d


d
d


d


l
 0
 0
o
c

c
l





















d

d



#
d







c




i
#i

end
end
end
end


end
#d
end
end

#o
#



  #
l



end

end






 0
end

end
end
l
 0
end
end
end
c


l


end


end
l

*

*l
l
l
l
l
end
#
 0
 0
l





*


#l
#o


*l
#d
*#d
*l
 0
#l
#d
*
*d
d
#

*d
d
d
d
#d
#d
#
*
o
c

#
#l
*l
l
l
l

l
   
l
 0
d
 
d
 0

 0
 0
 
l
#l
o







#
#
 0
 0
#l
 





l
l

o
o

d
d
 0
o




d
#
 


 0

#


l
l
 0
 0
l
 0





 