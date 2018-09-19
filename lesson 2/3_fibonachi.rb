fibonachi_numbers = [0, 1]
index = 1
loop do
  fib_next_value = fibonachi_numbers[index - 1] + fibonachi_numbers [index];
  break if fib_next_value > 100
  fibonachi_numbers.push(fib_next_value);
  index += 1;
end
puts fibonachi_numbers;

