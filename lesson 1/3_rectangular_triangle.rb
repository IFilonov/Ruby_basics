sides = []
puts "Please, enter side length of triangle:"
sides[0] = gets.chomp.to_f
puts "Please, enter length of next side:"
sides[1] = gets.chomp.to_f
puts "Please, enter length of last side:"
sides[2] = gets.chomp.to_f

sides.sort!

types = [["rectangular",0],["isosceles",0],["equilateral",0]]

if sides[2]**2 == sides[1]**2 + sides[0]**2 
  types [0][1] = 1
end
if sides[0] == sides[1]
  types [1][1] = 1
  if sides[1] == sides[2]
    types [2][1] = 1
  end
end

puts "Triangle is: "
types.each {|type, ind| puts type if ind>0}