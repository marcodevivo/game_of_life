class InputReader
  # Legge il file di input da path predefinito e restituisce i dati necessari per il game of life
  def self.read
    generation_number = 0
    rows = cols = 0
    grid = []
    file_name = 'public/input.txt'

    # Verifica se il file esiste
    unless File.exist?(file_name)
      raise "Errore: File non trovato - '#{file_name}'"
    end

    File.open(file_name, 'r') do |file|
      # Legge e valida la riga della generazione
      generation_line = file.readline.strip
      unless generation_line.match?(/^Generation \d+:$/)
        raise "Errore: formato della riga della generazione non valido (esempio corretto: 'Generation 3:')"
      end
      # Estrae il numero della generazione
      generation_number = generation_line.split[1].to_i

      # Legge e valida la riga della dimensione della griglia
      grid_size_line = file.readline.strip
      unless grid_size_line.match?(/^\d+ \d+$/)
        raise "Errore: formato della riga dimensioni della griglia non valido (esempio corretto: '4 8')"
      end
      # Estrae righe e colonne
      rows, cols = grid_size_line.split.map(&:to_i)

      # Legge e valida la griglia
      grid = []
      file.each_line do |line|
        line = line.strip
        if line.length != cols
          raise "Errore: griglia con numero di colonne non corretto. Colonne dichiarate: #{cols}, Colonne trovate: #{line.length}"
        end
        unless line.match?(/^[\*\.\s]*$/)
          raise "Errore: griglia contiene caratteri non validi (solo '*' e '.' sono ammessi)"
        end
        grid << line.chars
      end

      if grid.length != rows
        raise "Errore: griglia con numero di righe non corretto. Righe dichiarate: #{rows}, Righe trovate: #{grid.length}"
      end
    end

    return generation_number, rows, cols, grid
  end
end
