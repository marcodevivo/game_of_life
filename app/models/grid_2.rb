class Grid
  # Costruttore che inizializza la griglia con il numero di righe, colonne e lo stato iniziale
  def initialize(rows, cols, initial_state)
    @rows = rows
    @cols = cols
    # Matrice che rappresenta la griglia
    @cells = Array.new(rows) { Array.new(cols, false) }
    # Creazione della griglia con lo stato iniziale
    create_grid(initial_state)
  end

  def create_grid(initial_state)
    # Per ogni riga dello stato iniziale
    initial_state.each_with_index do |row, r_index|
      # Per ogni carattere della riga
      row.chars.each_with_index do |char, c_index|
        # Se il carattere è '*' (vivo), mettiamo 'true' nella griglia, altrimenti 'false'
        if char == '*'
          @cells[r_index][c_index] = true
        else
          @cells[r_index][c_index] = false
        end
      end
    end
  end

  # Metodo che converte la griglia in una stringa leggibile
  def draw_grid
    grid_string = ""
    # Per ogni riga della griglia
    @cells.each do |row|
      row_string = ""
      # Per ogni cella nella riga
      row.each do |cell|
        # Se la cella è viva (true), aggiunge '*', altrimenti '.'
        row_string += cell ? '*' : '.'
      end
      # Aggiunge la riga alla griglia, andando a capo
      grid_string += row_string + "\n"
    end
    # Ripulisce l'ultima linea e restituisce la griglia
    grid_string.chomp
  end


  # Metodo che conta i vicini vivi per una cella specifica
  def live_neighbors_count(row, col)
    neighbor_offsets = [
      [-1, -1], [-1, 0], [-1, 1], # Riga sopra
      [0, -1],          [0, 1],    # Sinistra e destra
      [1, -1], [1, 0], [1, 1]     # Riga sotto
    ]
    live_neighbors = 0
    # Per ogni direzione dei vicini
    neighbor_offsets.each do |r_offset, c_offset|
      # Calcola le nuove posizioni riga e colonna
      r = row + r_offset
      c = col + c_offset
      # Verifica che la nuova posizione sia dentro i limiti della griglia
      if r >= 0 && r < @rows && c >= 0 && c < @cols
        # Se la cella è viva, incrementa il conteggio dei vicini vivi
        live_neighbors += 1 if @cells[r][c] == true
      end
    end
    live_neighbors
  end

  # Calcola la prossima generazione applicando le regole del gioco
  def next_generation
    # Crea una nuova matrice che conterrà lo stato della nuova generazione
    new_cells = Array.new(@rows) { Array.new(@cols, false) }

    # Per ogni cella nella griglia
    @rows.times do |r|
      @cols.times do |c|
        # Conta i vicini vivi
        live_neighbors = live_neighbors_count(r, c)

        if @cells[r][c] # Se la cella è viva
          # Una cella viva muore se ha meno di 2 vicini vivi o più di 3 vicini vivi, altrimenti sopravvive
          if live_neighbors < 2 || live_neighbors > 3
            new_cells[r][c] = false  # Muore
          else
            new_cells[r][c] = true   # Sopravvive
          end
        else # Se la cella è morta
          # Una cella morta diventa viva se ha esattamente 3 vicini vivi
          if live_neighbors == 3
            new_cells[r][c] = true   # Nasce una nuova cella
          end
        end
      end
    end

    # Sostituisce la griglia attuale con la nuova generazione
    @cells = new_cells
  end
end
