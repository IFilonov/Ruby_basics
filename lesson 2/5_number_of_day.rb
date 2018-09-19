day_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Please, enter day:"
day = gets.to_i
puts "Please, enter month:"
month = gets.to_i
puts "Please, enter year:"
year = gets.to_i

number_of_day = 0

if year % 4 == 0  &&  year % 100 != 0 || year % 400 == 0
  day_in_months[1] = 29
end

day_in_months.take(month-1).each { |day_in_month| number_of_day += day_in_month }

number_of_day += day

puts number_of_day
