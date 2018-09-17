puts "Please, enter a:"
a = gets.chomp.to_f
puts "Please, enter b:"
b = gets.chomp.to_f
puts "Please, enter c:"
c = gets.chomp.to_f

d = b**2 - 4*a*c
puts "Discriminant is #{d}"
if d>0  
  sqrt_d = Math.sqrt(d)	
  x1 = (-b + sqrt_d) / (2 * a)
  x2 = (-b - sqrt_d) / (2 * a)
  puts "X1 is #{x1}, X2 is #{x2}"
elsif d==0
  x1 = -b / (2 * a)
  puts "X1 and X2 is #{x1}"
else
  puts "No roots"  
end
