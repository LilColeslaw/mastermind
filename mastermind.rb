# frozen-string-literal: false

# store code as an array of numbers in strings
# when people enter a code have them enter 1234 for example and then use .split("")
# right number right spot if guess[x] == code[x]
# right number wrong spot if code.includes(x) -- start with no multiple same numbers
class Game
  def initialize
    @guesses = 0
    generate_code
  end

  private

  def generate_code
    puts 'Generating code...'
    sleep(1.5)
    @code = []
    4.times { add_num }
    puts "The code is #{@code}"
  end

  def add_num
    num = (rand * 7).to_i.to_s
    @code.include?(num) ? new_num : @code.push(num)
  end
end
