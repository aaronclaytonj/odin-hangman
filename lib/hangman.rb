# frozen_string_literal: true

class Hangman
  attr_reader :guesses, :answer, :curr_guess, :guessed_chars, :incorrect_chars, :guess

  def initialize
    @guesses = 0
    @answer = ''
    @curr_guess = ''
    @guessed_chars = []
    @incorrect_chars = []
    @guess = ''
  end

  def set_up
    @answer = get_answer
    @curr_guess = answer.gsub(/[a-z]/i, '_')
  end

  def play
    set_up
    loop do
      @guess = take_guess
      @guessed_chars << guess
      break if update(guess)

      puts "your answer- #{curr_guess}"
    end
    conclusion
  end

  def conclusion
    if curr_guess.split('').none?('_')
      puts "You WIN, congratulations! The correct answer was #{answer}"
    else
      puts "You lose :( the correct answer was #{answer}"
    end
  end

  def update(guess)
    if !answer.include?(guess)
      @guesses += 1
      puts "you have #{7 - guesses} tries left"
    else
      curr_guess.split('').each_with_index do |_char, index|
        @curr_guess[index] = guess if answer[index] == guess
      end
    end
    game_finished?
  end

  def game_finished?
    guesses > 6 || curr_guess.split('').none?('_')
  end

  def get_answer
    words = File.readlines('google_10000_english.txt')
    small_words = words.each.each_with_object([]) do |word, array|
      word.strip!
      array << word if (word.length >= 5) && (word.length <= 12)
    end
    small_words.sample
  end

  def take_guess
    puts 'Guess a letter:'
    @guess = gets.chomp.strip[0].to_s
    until guess.match?(/[a-zA-Z]/) && !guessed_chars.include?(guess)
      puts 'Invalid, please guess another letter'
      @guess = gets.chomp.strip[0]
    end
    guess.downcase
  end
end
