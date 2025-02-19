class Console::ConsoleGameOfLife
  def initialize(input_reader)
    @generation = input_reader.generation
    @rows, @cols = input_reader.grid_size
    @initial_state = input_reader.grid_state
    @grid = Console::ConsoleGrid.new(@rows, @cols, @initial_state)
  end

  def display_next_generation
    @generation += 1
    @grid.next_generation  # Calcola la prossima generazione

    # Pulisce la console, in questo caso lanciando il comando 'clear' (in base al sistema operativo)
    system('clear')  # Su Windows usa 'cls'
    puts "Generation #{@generation}:"  # Mostra la generazione
    puts "#{@rows} #{@cols}"  # Mostra il numero di righe e di colonne
    puts @grid.to_s  # Visualizza la griglia sotto forma di stringa
  end

  def play_generations(number_of_generations)
    number_of_generations.times do
      display_next_generation
      sleep(1)  # Attendi 1 secondo tra ogni generazione
    end
  end
end
