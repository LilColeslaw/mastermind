# frozen-string-literal: false

# class used to run the whole game - Game.new starts a new game
class Game
  def initialize
    generate_code
    play
  end

  private

  def play
    message = "The year is 2054. You have hacked into a fiat wallet worth well over a whole bitcoin.\n"\
              "There is only one remaining wall between you and the money. A 4 digit code. You have tried\n"\
              "to bypass it, but it is impossible. You will have to guess. From what you can see\n"\
              "in the code database for the wallet, it seems that the code has no repeats, and\n"\
              "the program will tell you whether or not any digits in your guess are included in the code,\n"\
              "and if they are, whether or not any are in the right spot (\'r\' means right spot and digit and \'d\' means"\
              " only right digit). This hints will be scrambled. A small line of red text below\nthe area you enter the "\
              "code in spells out a message - YOU HAVE 12 TRIES LEFT - \nGood luck...\n"
    type_out(message)
    12.times { |time| guess(time) }
    @win ? win_message : lose_message
  end

  def guess(time)
    type_out("What is your guess?\n")
    guess = gets.chomp.split('')
    if guess.length == 4 && guess == guess.uniq && guess.all? { |element| %w[1 2 3 4 5 6].include?(element) }
      result(guess)
      type_out("You have #{12 - (time + 1)} guesses remaining.\n") unless @win
    else
      invalid
      guess(time)
    end
  end

  def result(guess)
    result = ''
    @win = true
    guess.each_with_index do |digit, index|
      if @code[index] == digit
        result << 'r'
      elsif @code.include?(digit)
        result << 'd'
        @win = false
      else
        @win = false
      end
    end
    puts result.split('').shuffle.join('')
  end

  def win_message
    type_out("You guessed the correct code! You gain access to the account and send the money to your own\n"\
             "fiat account. There, you send it to a swap and exchange it for 1/2 monero 1/2 bitcoin.\n"\
             'You are rich! But more hacking will come. You are not done yet...')
  end

  def lose_message
    type_out("You failed to guess the code. The correct code was #{@code} (the wallet printed "\
              'a message telling you the correct code and that the code has been changed and the new '\
              "code will appear on the owner of the wallet\'s device).\nThe wallet has shut down "\
              "and alerted government authorities of your ip address, which you thought it couldn\'t access.\n"\
              'You might want to pack your things...')
  end

  def invalid
    puts "That's not a valid code. Remember, the code has no repeats, includes only the numbers"\
         '1-6, and is 4 digits long...'
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
    num = (rand * 6 + 1).to_i.to_s
    @code.include?(num) ? add_num : @code.push(num)
  end
end
Game.new
