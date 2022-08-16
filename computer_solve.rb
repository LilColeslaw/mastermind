# frozen-string-literal: false

require './feedback'

# will handle everything when the player wants to have the computer guess
class ComputerSolve
  include Feedback

  def initialize
    get_code
    algorithm_guess
  end

  private

  def get_code
    puts "Enter a code for the computer to guess. It must be 4\n"\
         'digits long and include only the numbers 1-6.'
    @code = gets.chomp.split('').map(&:to_i)
  end

  def algorithm_guess
    list
    11.times do |time|
      if time.zero?
        solving_message(1, [1, 1, 2, 2])
        pare([1, 1, 2, 2])
      else
        solving_message(time + 1, @list[0])
        pare(@list[0])
      end
      if @list.length.zero? # it's zero because we deleted the guess each time down in pare()
        win_message
        break
      end
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
    for i in 1..6
      for j in 1..6
        for k in 1..6
          for l in 1..6
            @list.push([i, j, k, l])
          end
        end
      end
    end
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
