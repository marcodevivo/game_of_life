class Grid
  attr_reader :current_state, :rows, :cols

  # Inizializza la griglia con il numero di righe e colonne e lo stato iniziale
  def initialize(rows, cols, grid_state)
    @rows = rows
    @cols = cols
    @current_state = populate_grid(grid_state)
  end

  # Metodo per creare la griglia partendo dallo stato iniziale
  def populate_grid(grid_state)
    # Inizializza una matrice con tutte le celle settate a false (false = morta, true = viva)
    grid = Array.new(@rows) { Array.new(@cols, false) }
    # Popola la griglia in base allo stato iniziale (con '*' e '.')
    grid_state.each_with_index do |row, r_index|
      row.chars.each_with_index do |char, c_index|
        # Se il carattere è '*' (vivo), mettiamo 'true' nella griglia, altrimenti 'false'
        if char == '*'
          grid[r_index][c_index] = true
        else
          grid[r_index][c_index] = false
        end
      end
    end
    grid
  end

  # Metodo per visualizzare la griglia in formato stringa
  def show_current_state
    result = ""
    # Per ogni riga della griglia
    @current_state.each do |row|
      # Per ogni cella della riga, aggiungiamo '*' se la cella è true (viva), altrimenti '.'
      row.each { |cell| result += cell ? '*' : '.' }
      result += "\n"
    end
    # Ripulisco l'ultima riga per farla rimanere vuota
    result.chomp
  end

  # Conta i vicini vivi di una cella
  def live_neighbors_count(row, col)
    directions = [
      [-1, -1], [-1, 0], [-1, 1],  # Riga sopra
      [0, -1],          [0, 1],    # Sinistra e destra
      [1, -1], [1, 0], [1, 1]      # Riga sotto
    ]

    # Conta quante volte la condizione è vera e restituisce quel numero (numero di vicini vivi)
    directions.count do |r_offset, c_offset|
      # Calcoliamo la posizione del vicino aggiungendo gli offset alla cella corrente
      r, c = row + r_offset, col + c_offset
      # Verifichiamo se il vicino è dentro i limiti della griglia
      # E se è vivo (ossia se la cella in quella posizione è true)
      r.between?(0, @rows - 1) && c.between?(0, @cols - 1) && @current_state[r][c]
    end
  end

  # Calcola la successiva generazione della griglia
  def next_generation
    # Inizializza una matrice con tutte le celle settate a false (false = morta, true = viva)
    new_grid = Array.new(@rows) { Array.new(@cols, false) }
    # Esamina ogni cella della griglia
    @rows.times do |row|
      @cols.times do |col|
        # Conta il numero di vicini vivi
        live_neighbors = live_neighbors_count(row, col)
        if @current_state[row][col]  # La cella è viva
          # Regola 1: Una cella viva con meno di 2 vicini vivi muore
          # Regola 3: Una cella viva con più di 3 vicini vivi muore
          if live_neighbors < 2 || live_neighbors > 3
            new_grid[row][col] = false  # La cella muore
          else
            # Regola 2: Una cella viva con 2 o 3 vicini vivi sopravvive
            new_grid[row][col] = true  # La cella sopravvive
          end
        else  # La cella è morta
          # Regola 4: Una cella morta con esattamente 3 vicini vivi diventa viva
          if live_neighbors == 3
            new_grid[row][col] = true  # La cella diventa viva
          end
        end
      end
    end
    # Sostituisci la griglia attuale con la nuova griglia
    @current_state = new_grid
  end
end