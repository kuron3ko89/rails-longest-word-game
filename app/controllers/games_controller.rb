require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @gameboard = []
    @array = ('a'..'z').to_a
    @gameboard = @array.sample(10)
  end

  def gridchecker(input, grid)
    input.chars.each do |letter|
      if input.count(letter) > grid.count(letter)
        return false
      end
    end
    return true
  end

  def score
    input = params[:input]
    @answer = ""
    grid = params[:gameboard]
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    dict_match = open(url).read
    attempt_json = JSON.parse(dict_match)
    if attempt_json["found"] == true && gridchecker(input,grid) == true
      @answer = "Congratulations #{input} is a valid word"
    else
      @answer = "Sorry but #{input} is not a valid word"
    end

  end
  
  
end
