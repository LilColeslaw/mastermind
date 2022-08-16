# frozen-string-literal: false

# gives feedback on guesses in the game
module Feedback
  def feedback(guess, solution)
    feedback = { correct: 0, half_correct: 0 }
    correct_info = correct(guess, solution)
    feedback[:correct] = correct_info[0]
    feedback[:half_correct] = half_correct(correct_info[1], correct_info[2])
    feedback
  end

  def correct(guess, solution)
    remains = [0, [], []]
    guess.each_with_index do |digit, index|
      if solution[index] == digit
        remains[0] += 1
      else # adds the parts that don't match together to the two arrays
        remains[1] << solution[index]
        remains[2] << digit
      end
    end
    remains
  end

  def half_correct(guess_left, code_left)
    num = 0
    i = 0
    while i < guess_left.length # going to iterate i for every part of the guess
      if code_left.include? guess_left[i]
        num += 1
        code_left.delete_at(code_left.index(guess_left[i]))
        guess_left.delete_at(i)
      else
        i += 1
      end
    end
    num
  end
end
