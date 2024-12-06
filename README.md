# Extendi - Game Of Life

This code is based on [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)

The game is implemented directly on the console, with the following features:

* Reading the input file from a predefined path, with format validation

* Variable dot matrix based on input file

* Display of the matrix and generations

* Console update with each iteration

## Implementation
The initial state (the current generation) will be provided via a text file that specifies:
* the current generation number
* the grid size
* the population state (`*` represents a live cell, `.` represents a dead cell)

In the following input file example we can see an input file specifying the third generation on a 4 by 8 grid:
```
Generation 3:
4 8
........
....*...
...**...
........
```

The input file is called "input.txt" and is located within the project in the "public" folder

The output will generate N subsequent generations and show the result of the matrix at each iteration in the console

## Getting started

To launch the application you need to create an InputReader object to be able to read the file:

```console
input_reader = InputReader.new('public/input.txt')
```

After that, we need to create an ExtendiGameOfLife object passing the result of InputReader:

```console
game = ExtendiGameOfLife.new(input_reader)
```

That's it, now we are ready to run the game for N iterations:

```console
game.play_generations(25)
```

You can also find the previous commands to launch in the console in the "seeds.rb" file where they have been inserted for greater convenience
