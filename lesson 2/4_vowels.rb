vowels_hash = {}
vowels_arr = ['a', 'e', 'i', 'o', 'u']

("a".."z").each_with_index do |letter, index|
  vowels_arr.each { |vowel| vowels_hash[vowel] = index+1 if letter == vowel }
end

puts vowels_hash
