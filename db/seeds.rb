# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Crea un oggetto InputReader per leggere il file
input_reader = InputReader.new('public/input.txt')

# Crea un oggetto ExtendiGameOfLife passando il risultato di InputReader
game = ExtendiGameOfLife.new(input_reader)

# Avvia il gioco per N generazioni
game.play_generations(25)
