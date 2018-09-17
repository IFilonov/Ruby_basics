sides = []
puts "Please, enter side length of triangle:"
sides[0] = gets.to_f
puts "Please, enter length of next side:"
sides[1] = gets.to_f
puts "Please, enter length of last side:"
sides[2] = gets.to_f

sides.sort!

types = [["rectangular", 0], ["isosceles", 0], ["equilateral", 0]]

sqrt_hyp = sides[2]**2
sum_sqrt_cat = sides[1]**2 + sides[0]**2

if sqrt_hyp == sum_sqrt_cat and sides[0] == sides[1]
  types [0][1] = 1
  types [1][1] = 1
elsif sqrt_hyp == sum_sqrt_cat
  types [0][1] = 1
elsif sides[0] == sides[1] and sides[0] == sides[2]
  types [1][1] = 1
  types [2][1] = 1
end

puts "Triangle is: "
types.each { |type, ind| puts type if ind == 1 }
