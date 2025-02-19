class GamesController < ApplicationController
  before_action :authenticate_user!

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    begin
      file = params[:game][:input_file]
      input_reader = InputReader.new(file)
      # Legge e valida il file caricato lanciando eccezione in caso di errore
      input_reader.read_and_validate
      if @game.save
        flash[:notice] = "Gioco creato con successo!"
        redirect_to game_path(@game)
      else
        flash[:alert] = "Errore nella creazione del gioco. Riprova"
        redirect_to new_game_path
      end
    rescue StandardError => e
      flash[:alert] = e
      redirect_to new_game_path
    end
  end

  def show
    @game = Game.find(params[:id])
    @game_of_life_file = @game.input_file.download
  end

  def generate
    @game = Game.find(params[:id])
    iterations = @game.number_of_generations
    begin
      input_reader = InputReader.new(@game.input_file)
      # Legge e valida il file caricato lanciando eccezione in caso di errore
      input_reader.read_and_validate
      number_of_generation = input_reader.generation
      rows, cols = input_reader.grid_size
      initial_state = input_reader.grid_state
      grid = Grid.new(rows, cols, initial_state)

      iterations.times do |i|
        sleep 1
        number_of_generation += 1
        grid.next_generation
        ActionCable.server.broadcast("game_of_life", { number_of_generation: number_of_generation, rows: rows, cols: cols, grid: grid.matrix_to_string })
      end
      head :ok
    rescue StandardError => e
      flash[:alert] = e
      redirect_to game_path(@game)
    end
  end

  private
  def game_params
    params.require(:game).permit(:number_of_generations, :input_file)
  end
end
