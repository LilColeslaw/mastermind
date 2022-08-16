# frozen-string-literal: false

require './feedback'

# will handle everything when the player wants to have the computer guess
class ComputerSolve
  include Feedback

  def initialize
    ask_code
    list
    algorithm_guess
  end

  private

  def ask_code
    puts "Enter a code for the computer to guess. It must be 4\n"\
         'digits long and include only the numbers 1-6.'
    @code = gets.chomp.split('').map(&:to_i)
  end

  def algorithm_guess
    11.times do |time|
      if time.zero?
        solving_message(1, [1, 1, 2, 2])
        pare([1, 1, 2, 2])
      else
        solving_message(time + 1, @list[0])
        pare(@list[0])
      end
      break win_message if @list.length.zero? # it's zero because we deleted the guess each time down in pare()

      lose_message if time == 11 # if we made it to the end of the 12th guess time, they lost
    end
  end

  def pare(guess)
    feedback = feedback(guess, @code)
    @list.filter! { |guess_variation| feedback(guess, guess_variation) == feedback }
    @list.delete(guess) # have to delete the guess because otherwise it might repeatedly try the same one
  end

  def list
    @list = []
    (1..6).each { |i| (1..6).each { |j| (1..6).each { |k| (1..6).each { |l| @list.push([i, j, k, l]) } } } }
  end

  def solving_message(time, guess)
    puts "Computer guess ##{time}: #{guess}"
  end

  def win_message
    puts 'The computer won... it is hard to beat a computer, after all.'
  end

  def lose_message
    puts 'Amazing! You beat the computer.'
  end
end
