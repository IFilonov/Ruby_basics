LIMIT = 100

fibonachi_numbers = [0, 1]

fib_next_value = 0

while fib_next_value <= LIMIT do
  fib_next_value = fibonachi_numbers[-2] + fibonachi_numbers[-1];
  fibonachi_numbers.push(fib_next_value) if fib_next_value <= LIMIT;
end

puts fibonachi_numbers;

