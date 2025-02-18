class GameOfLifeController < ApplicationController
  before_action :authenticate_user!

  def upload
    @input_reader = InputReader.new('public/input.txt')
  end

  def play_generations
  end
end
