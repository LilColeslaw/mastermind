# frozen-string-literal: false

# will handle everything when the player wants to have the computer guess
class ComputerSolve
  def initialize
    get_code
    solve(@code)
  end

  private

  def get_code
    puts "Enter a code for the computer to guess. It must be 4\n"\
         'digits long and include only the numbers 1-6.'
    @code = gets.chomp.split('').map(&:to_i)
  end

  def solve(code)
    12.times do |time|
      my_guess = guess
      break win_message(guess) if my_guess == code

      solving_message(time + 1, my_guess)
      puts 'The computer lost! Nice job defeating it!' if time == 11
    end
  end

  def guess
    guess = []
    4.times { guess.push (rand * 6 + 1).to_i }
    guess
  end

  def solving_message(time, guess)
    puts "Computer guess ##{time}: #{guess}"
  end
end
