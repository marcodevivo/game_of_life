class Grid
  def initialize(rows, cols, initial_state)
    @rows = rows
    @cols = cols
    # Inizializza una matrice vuota di celle (false = morta, true = viva)
    @cells = Array.new(rows) { Array.new(cols, false) }
    # Popola la griglia con lo stato iniziale
    populate_grid(initial_state)
  end

  def populate_grid(initial_state)
    initial_state.each_with_index do |row, r_index|
      row.chars.each_with_index do |char, c_index|
        @cells[r_index][c_index] = (char == '*')
      end
    end
  end

  # Metodo che converte la griglia in una stringa leggibile
  def to_s
    # Ritorna la griglia sotto forma di stringa, con '*' per le celle vive e '.' per quelle morte
    @cells.map { |row| row.map { |cell| cell ? '*' : '.' }.join }.join("\n")
  end

  def next_generation
    # Crea una nuova matrice per la generazione successiva
    new_cells = Array.new(@rows) { Array.new(@cols, false) }

    # Itera su tutte le celle per calcolare la generazione successiva
    @rows.times do |r|
      @cols.times do |c|
        live_neighbors = live_neighbors_count(r, c)

        # Regole di Conway
        if @cells[r][c]  # Cellula viva
          new_cells[r][c] = (live_neighbors == 2 || live_neighbors == 3)
        else  # Cellula morta
          new_cells[r][c] = (live_neighbors == 3)
        end
      end
    end

    # Aggiorna la griglia con la nuova generazione
    @cells = new_cells
  end

  private

  def live_neighbors_count(row, col)
    # Calcola il numero di celle vive intorno alla cella (row, col)
    offsets = [-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]
    live_count = 0

    offsets.each do |r_offset, c_offset|
      r, c = row + r_offset, col + c_offset
      if r >= 0 && r < @rows && c >= 0 && c < @cols && @cells[r][c]
        live_count += 1
      end
    end

    live_count
  end
end
