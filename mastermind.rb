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
    puts 'Would you like to be the code-solver or code-maker (enter 1 or 2 to choose)?'
    answer = gets.chomp
    case answer
    when '1' then solving
    when '2' then ComputerSolve.new
    else mode_error
    end
  end

  def mode_error
    puts "That wasn't a 1 or a 2. Please enter only one of those options."
    which_mode
  end

  def solving
    puts "You will try to guess a 4-digit code. The code uses the numbers 1-6, and\n"\
              "the program will give you feedback on each guess. You will have 12 tries. \nGood luck..."
    12.times { |time| guess(time) unless @win }
    @win ? win_message : lose_message
  end

  def guess(time)
    puts 'What is your guess?'
    guess = gets.chomp.split('')
    if guess.length == 4 && guess.all? { |element| %w[1 2 3 4 5 6].include?(element) }
      result(guess.map)
      puts "You have #{12 - (time + 1)} guesses remaining." unless @win
    else
      invalid
      guess(time)
    end
  end

  def result(guess)
    @result = feedback(guess, @code)
    @win = true if @result[:correct] == 4 # the player won!
    puts "Completely correct digits: #{@result[:correct]}\nRight digit wrong spot: #{@result[:half_correct]}" # print the feedback
  end

  def win_message
    puts 'You guessed the correct code! Nice job!'
  end

  def lose_message
    puts "You failed to guess the code. The correct code was #{@code}"
  end

  def invalid
    puts "That's not a valid code. Remember, the code includes only the numbers"\
         '1-6, and is 4 digits long...'
  end

  def generate_code
    @code = []
    4.times { @code.push((rand * 6 + 1).to_i.to_s) }
  end
end
Game.new
