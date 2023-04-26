# frozen_string_literal: true

require_relative 'hangman'

game = Hangman.new
game.play

loop do
  puts 'Would you like to play again? (y/n)'
  input = gets.chomp.strip[0]
  break if input == 'n'

  game = Hangman.new
  game.play
end

puts 'Thank you for playing :)'
