class InputReader
  attr_reader :generation, :grid_size, :grid_state

  # Legge il file di input da path predefinito e restituisce i dati necessari per il Game of Life
  def initialize(file_path)
    @file_path = file_path
    @generation = nil
    @grid_size = nil
    @grid_state = []
    read_input_file
  end

  def read_input_file
    # Verifica se il file esiste
    unless File.exist?(@file_path)
      raise "Errore: File non trovato per il path '#{@file_path}'"
    end

    # Legge tutte le righe del file, rimuovendo gli spazi vuoti e restituisce un array
    file_lines = File.readlines(@file_path).map(&:strip)

    # Verifica che il formato del file sia valido
    validate_file_format(file_lines)

    # Estrae la generazione iniziale e le dimensioni della griglia
    @generation = extract_generation(file_lines[0])
    @grid_size = extract_grid_size(file_lines[1])
    @grid_state = file_lines[2..-1]

    # Verifica che la griglia abbia il numero corretto di righe e colonne
    validate_grid_size
  end

  private

  def validate_file_format(file_lines)
    # Controlla che il file contenga almeno 3 righe
    raise "Errore: Il file deve contenere almeno 3 righe" if file_lines.length < 3
    # La prima riga deve contenere 'Generation X:'
    raise "Errore: La prima riga deve contenere la generazione (esempio: 'Generation 3:')" unless file_lines[0].match?(/^Generation \d+:/)
    # La seconda riga deve contenere le dimensioni della griglia (es. "4 8")
    raise "Errore: La seconda riga deve contenere le dimensioni della griglia (esempio: '4 8')" unless file_lines[1].match?(/^\d+\s+\d+$/)
    # Le righe successive devono contenere solo '.' e '*'
    file_lines[2..-1].each { |line| raise "Errore: Griglia non valida" unless line.match?(/^[.*]+$/) }
  end

  def validate_grid_size
    total_rows, total_cols = @grid_size
    # Verifica il numero di righe nella griglia
    raise "Errore: Il numero di righe nella griglia non corrisponde a quello specificato" if @grid_state.length != total_rows
    # Verifica il numero di colonne in ogni riga
    @grid_state.each do |row|
      raise "Errore: Ogni riga della griglia deve avere #{total_cols} colonne" if row.length != total_cols
    end
  end

  def extract_generation(generation_line)
    # Estrae il numero di generazione dalla prima riga
    generation_line.match(/^Generation (\d+):/)[1].to_i
  end

  def extract_grid_size(grid_size_line)
    # Estrae le dimensioni della griglia dalla seconda riga
    grid_size_line.split.map(&:to_i)
  end
end
