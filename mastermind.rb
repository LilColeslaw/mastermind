# frozen-string-literal: false

# class used to run the whole game - Game.new starts a new game
class Game
  def initialize
    generate_code
    play
  end

  private

  def play
    message = "You will try to guess a 4-digit code. The code uses the numbers 1-6, and\n"\
              "the program will tell you whether or not any digits in your guess are included in the code,\n"\
              "and if they are, whether or not any are in the right spot (\'r\' means right spot\nand digit and \'d\' means"\
              " only right digit). This hints will be scrambled. You will have 12 tries. \nGood luck...\n"
    type_out(message)
    12.times { |time| guess(time) unless @win }
    @win ? win_message : lose_message
  end

  def guess(time)
    type_out("What is your guess?\n")
    guess = gets.chomp.split('')
    if guess.length == 4 && guess.all? { |element| %w[1 2 3 4 5 6].include?(element) }
      result(guess)
      type_out("You have #{12 - (time + 1)} guesses remaining.\n") unless @win
    else
      invalid
      guess(time)
    end
  end

  def result(guess)
    @result = []
    left_over = correct(guess)
    if left_over[:code_left].length.zero? # did everything cancel out? then the player won!
      @win = true
    else # otherwise, take the left-overs and see if anything is partly correct
      half_correct(left_over) # no need to use the result of this - it directly modifies @result
    end
    puts @result.shuffle.join('') # print the feedback, but shuffled!
  end

  # will return a hash with the left-overs in the code, and the left-overs in the guess
  def correct(guess)
    code_left_over = []
    guess_left_over = []
    guess.each_with_index do |digit, index|
      if @code[index] == digit
        @result << 'r'
      else # adds the parts that don't match together to the two arrays
        code_left_over << @code[index]
        guess_left_over << digit
      end
    end
    { code_left: code_left_over, guess_left: guess_left_over }
  end

  def half_correct(left_over)
    i = 0
    while i < left_over[:guess_left].length # going to iterate i for every part of the guess
      if left_over[:code_left].include? left_over[:guess_left][i]
        @result << 'd'
        left_over[:code_left].delete_at(left_over[:code_left].index(left_over[:guess_left][i]))
        left_over[:guess_left].delete_at(i)
        i -= 1 # because an element was just deleted everything is going to shift back 1 index
      else
        i += 1
      end
    end
  end

  def win_message
    type_out('You guessed the correct code! Nice job'\
             "\n")
  end

  def lose_message
    type_out("You failed to guess the code. The correct code was #{@code}")
  end

  def invalid
    puts "That's not a valid code. Remember, the code includes only the numbers"\
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
    4.times { @code.push((rand * 6 + 1).to_i.to_s) }
    p @code
  end
end
Game.new
