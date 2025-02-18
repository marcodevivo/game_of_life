class GamesController < ApplicationController
  before_action :authenticate_user!

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:alert] = "Gioco creato con successo!"
      redirect_to root_path
    else
      flash[:alert] = "Errore nella creazione del gioco. Riprova."
      render :new
    end
  end

  private
  def game_params
    params.require(:game).permit(:number_of_generations, :input_file)
  end
end
