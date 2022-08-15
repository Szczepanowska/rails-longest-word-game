require 'open-uri'
require 'json'

class GamesController < ApplicationController
  # LETTERS = Array.new(10) { ('A'..'Z').to_a.sample }
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @my_word = params[:word]
    @letters = params[:letters]
    @counter = 0

    url = "https://wagon-dictionary.herokuapp.com/#{@my_word}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    clear_attempt = @my_word.upcase.chars

    if clear_attempt
      if clear_attempt.all? { |char| clear_attempt.count(char) <= @letters.count(char) }
        if word['found']
          @score = "Congratulations! #{@my_word} is a valid english word"
          @counter += @my_word.length
        else
          @score = "Sorry, #{@my_word} is not an english words"
        end
      else
        @score = "Sorry, #{@my_word} is not build out of #{@letters}"
      end
    end
  end
end
