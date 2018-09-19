products = {}
total_sum = 0.0

loop do
puts "Please, enter product name (or stop to exit):"
product = gets.chomp.to_s
break if product == "stop"
puts "Please, enter product price:"
price = gets.to_f
puts "Please, enter amount of products:"
amount = gets.to_f
products[product] = {price => amount}
end

products.each { |product|
  product_sum = product.to_a[1].to_a[0][0] * product.to_a[1].to_a[0][1]
  total_sum += product_sum
  print product
  puts " product sum: #{product_sum}"
  }
puts "Total sum: #{total_sum}"
