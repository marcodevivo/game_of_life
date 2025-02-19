class GamesController < ApplicationController
  before_action :authenticate_user!

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    begin
      if @game.save
        input_reader = InputReader.new(@game.input_file)
        input_reader.read_input_file
        flash[:notice] = "Gioco creato con successo!"
        redirect_to game_path(@game)
      else
        flash[:alert] = "Errore nella creazione del gioco. Riprova"
        redirect_to new_game_path
      end
    rescue StandardError => e
      @game.destroy
      flash[:alert] = e
      redirect_to new_game_path
    end
  end

  def show
    @game = Game.find(params[:id])
    @game_of_life_file = @game.input_file.download
  end

  private
  def game_params
    params.require(:game).permit(:number_of_generations, :input_file)
  end
end
