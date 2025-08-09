def by_length(arr)
  words = {1=>"One",2=>"Two",3=>"Three",4=>"Four",5=>"Five",6=>"Six",7=>"Seven",8=>"Eight",9=>"Nine"}
  arr.select { |x| x.between?(1,9) }
     .sort
     .reverse
     .map { |x| words[x] }
end