puts "Please, enter your name:"
name = gets.chomp.capitalize
puts "Enter height (sm):"
height = gets.to_f
ideal_weight = height - 110
if ideal_weight >= 0
  puts "#{name}, your ideal weight: #{ideal_weight} kg"
else
  puts "#{name}, your weight already ideal"
end
