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
  products[product] = { price: price, amount: amount }
end

products.each_pair do |product, prod_attr|
  product_sum = prod_attr[:price] * prod_attr[:amount]
  total_sum += product_sum
  print product
  print prod_attr
  puts " product sum: #{product_sum}"
end

puts "Total sum: #{total_sum}"
