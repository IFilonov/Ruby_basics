vowels_hash = {}
vowels_arr = ['a', 'e', 'i', 'o', 'u']
index = 1
for letter in "a".."z"
  vowels_arr.each {|vowel| vowels_hash[vowel] = index if letter == vowel}
  index += 1
end
puts vowels_hash
