def no_dupes?(arr)
    counts = Hash.new(0)
    arr.each {|val| counts[val] += 1}
    arr.select {|val| counts[val] == 1}
end

# Examples
# print no_dupes?([1, 1, 2, 1, 3, 2, 4]).to_s  + "\n"     # => [3, 4]
# print no_dupes?(['x', 'x', 'y', 'z', 'z']).to_s + "\n"    # => ['y']
# print no_dupes?([true, true, true]).to_s    + "\n"        # => []

def no_consecutive_repeats?(arr)
    no_consecutives = true
    arr.each_with_index do |elem, idx|
        no_consecutives = false if elem == arr[idx+1]
    end
    return no_consecutives
end

# Examples
# puts no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# puts no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# puts no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# puts no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# puts no_consecutive_repeats?(['x'])                              # => true

def char_indices(str)
    index_hash = Hash.new{ |h, k| h[k] = []}
    str.each_char.with_index do |char, idx|
        index_hash[char] << idx
    end
    return index_hash
end

# Examples
# puts char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# puts char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    streak_length = 0
    streak_string = ""
    str.each_char.with_index do |char1, idx1|
        current_streak = 1
        current_sub = char1
        str[idx1 + 1...str.length].each_char.with_index do |char2, idx2|
            if char2 != char1
                break
            else
                current_streak += 1
                current_sub += char2
            end
        end
        if current_streak >= streak_length
            streak_length = current_streak
            streak_string = current_sub
        end
    end
    return streak_string
end

# Examples
# puts longest_streak('a')           # => 'a'
# puts longest_streak('accccbbb')    # => 'cccc'
# puts longest_streak('aaaxyyyyyzz') # => 'yyyyy
# puts longest_streak('aaabbb')      # => 'bbb'
# puts longest_streak('abc')         # => 'c'

def bi_prime?(num)
    primes = list_primes(num)
    primes.each_with_index do |elem1, idx1|
        primes[idx1...primes.length].each do |elem2|
            return true if elem1 * elem2 == num
        end
    end
    return false
end

def list_primes(num)
    return [] if num < 2
    results = []
    (2...num).each do |elem|
        prime = true
        (2...elem).each do |factor|
            prime = false if elem % factor == 0
        end
        results << elem if prime
    end
    return results
end

# Examples
# puts bi_prime?(14)   # => true
# puts bi_prime?(22)   # => true
# puts bi_prime?(25)   # => true
# puts bi_prime?(94)   # => true
# puts bi_prime?(24)   # => false
# puts bi_prime?(64)   # => false

def vigenere_cipher(message, keys)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    cycle = 0
    result = ""

    message.each_char do |char|
        result += alphabet[(alphabet.index(char) + keys[cycle % keys.length]) % alphabet.length]
        cycle += 1
    end

    return result
end

# Examples
# puts vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# puts vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# puts vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# puts vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# puts vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
    vowels = "aeiou"
    last_vowel = ""

    result = ""
    str.each_char.with_index do |char, idx|
        if vowels.include?(char)
            if last_vowel == ""
                last_vowel = get_last_vowel(str)
            end
            result << last_vowel
            last_vowel = str[idx]
        else
            result << char
        end
    end
    return result
end

def get_last_vowel(str)
    vowels = "aeiou"
    last_vowel = ""
    str.each_char do |char|
        last_vowel = char if vowels.include?(char)
    end
    return last_vowel
end

# Examples
# puts vowel_rotate('computer')      # => "cempotur"
# puts vowel_rotate('oranges')       # => "erongas"
# puts vowel_rotate('headphones')    # => "heedphanos"
# puts vowel_rotate('bootcamp')      # => "baotcomp"
# puts vowel_rotate('awesome')       # => "ewasemo"

class String
    def select(&prc)
        result = ""
        return result if prc == nil

        self.each_char do |char|
            result += char if prc.call(char)
        end

        return result
    end

    def map!(&prc)
        self.each_char.with_index do |char, idx|
            self[idx] = prc.call(char, idx)
        end
        return self
    end
end

# Examples
# puts "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# puts "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# puts "HELLOworld".select          # => ""

# Examples
# word_1 = "Lovelace"
# word_1.map! do |ch| 
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"

def multiply(a, b)
    return 0 if b == 0
    return (a + multiply(a, b-1)) if b > 0
    return (multiply(a, b+1) - a) if b < 0
end

# Examples
# puts multiply(3, 5)        # => 15
# puts multiply(5, 3)        # => 15
# puts multiply(2, 4)        # => 8
# puts multiply(0, 10)       # => 0
# puts multiply(-3, -6)      # => 18
# puts multiply(3, -6)       # => -18
# puts multiply(-3, 6)       # => -18

def lucas_sequence(length)
    return [] if length == 0
    return [2] if length == 1
    return [2,1] if length == 2
    return lucas_sequence(length-1) + [lucas_sequence(length-1)[length-2]+lucas_sequence(length-2)[length-3]] 
end

# Examples
# puts lucas_sequence(0).to_s + "\n"  # => []
# puts lucas_sequence(1).to_s + "\n"   # => [2]    
# puts lucas_sequence(2).to_s + "\n"   # => [2, 1]
# puts lucas_sequence(3).to_s + "\n"   # => [2, 1, 3]
# puts lucas_sequence(6).to_s + "\n"   # => [2, 1, 3, 4, 7, 11]
# puts lucas_sequence(8).to_s + "\n"   # => [2, 1, 3, 4, 7, 11, 18, 29]

def prime_factorization(num)
    if is_prime(num)
        return [num]
    else
        n = 2
        while (num % n) != 0
            n += 1
        end
        return [n] + prime_factorization(num / n)
    end
end

def is_prime(num)
    return false if num < 2
    prime = true

    (2...num).each do |n|
        prime = false if num % n == 0
    end

    return prime
end

# Examples
# puts prime_factorization(12).to_s     # => [2, 2, 3]
# puts prime_factorization(24).to_s     # => [2, 2, 2, 3]
# puts prime_factorization(25).to_s     # => [5, 5]
# puts prime_factorization(60).to_s     # => [2, 2, 3, 5]
# puts prime_factorization(7).to_s      # => [7]
# puts prime_factorization(11).to_s     # => [11]
# puts prime_factorization(2017).to_s   # => [2017]