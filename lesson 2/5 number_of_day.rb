day_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Please, enter day:"
day = gets.to_i
puts "Please, enter month:"
month = gets.to_i
puts "Please, enter year:"
year = gets.to_i

number_of_day = day

for index in 2..month
  number_of_day += day_in_months[index-2]
end

if ((year % 4 == 0  &&  year % 100 != 0) || year % 400 == 0)
  number_of_day += 1
end

puts number_of_day
