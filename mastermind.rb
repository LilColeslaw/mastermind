# frozen-string-literal: false

# store code as an array of numbers in strings
# when people enter a code have them enter 1234 for example and then use .split("")
# right number right spot if guess[x] == code[x]
# right number wrong spot if code.includes(x) -- start with no multiple same numbers
class Game
  def initialize
    @guesses = 0
    generate_code
    play
  end

  private

  def play
    message = "The year is 2054. You have hacked into a fiat wallet worth well over a whole bitcoin.\n"\
              "There is only one remaining wall between you and the money. A 4 digit code. You have tried\n"\
              "to bypass it, but it is impossible. You will have to guess. From what you can see\n"\
              "in the code database for the wallet, it seems that the code has no repeats, and\n"\
              "the program will tell you whether or not each digit in your guess is included in the code,\n"\
              "and if it is, whether or not it is in the right spot. A small line of red text below\n"\
              'the area you enter the code in spells out a message - YOU HAVE 3 TRIES LEFT - . Good luck.'
    type_out(message)
    3.times { guess }
    win ? win_message : lose_message
  end

  def type_out(message)
    message.each_char do |char|
      print char
      case char
      when '.' then sleep(0.35)
      when ',' then sleep(0.2)
      else sleep(0.1)
      end
    end
  end

  def generate_code
    @code = []
    4.times { add_num }
  end

  def add_num
    num = (rand * 7).to_i.to_s
    @code.include?(num) ? add_num : @code.push(num)
  end
end
