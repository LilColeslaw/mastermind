# frozen-string-literal: false

require './computer_solve'
require './feedback'

# class used to run the whole game - Game.new starts a new game
class Game
  include Feedback

  def initialize
    generate_code
    which_mode
  end

  private

  def which_mode
    type_out "Would you like to be the code-solver or code-maker (enter 1 or 2 to choose)\n"
    answer = gets.chomp
    case answer
    when '1' then solving
    when '2' then ComputerSolve.new
    else mode_error
    end
  end

  def mode_error
    type_out "That wasn't a 1 or a 2. Please enter only one of those options"
    which_mode
  end

  def solving
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
      result(guess.map)
      type_out("You have #{12 - (time + 1)} guesses remaining.\n") unless @win
    else
      invalid
      guess(time)
    end
  end

  def result(guess)
    @result = feedback(guess, @code)
    @win = true if @result[:correct] == 4 # the player won!
    puts @result # print the feedback
  end

  def win_message
    type_out('You guessed the correct code! Nice job'\
             "\n")
  end

  def lose_message
    type_out("You failed to guess the code. The correct code was #{@code}\n")
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
  end
end
Game.new
