require 'open-uri'

class GamesController < ApplicationController
  def new
    grid = []
    10.times { grid << ('A'..'Z').to_a.sample }
    @letters = grid
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @score = 0
    json = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
    if @word.upcase.chars.all? { |l| @word.upcase.chars.count(l) <= @letters.count(l) }
      if json['found']
        @score = @word.length * 10
        @message = 'Nice one!'
      else
        @message = "We couldn't find that word, sorry!"
      end
    else
      @message = 'Oops...looks like you used letters not on the board!'
    end
  end
end
