# Game Of Life - Extendi

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

The InputReader class will read and validate the file loaded directly from the graphic interface while the Grid class will take care of the calculation of the new generation

The output will generate N subsequent generations and show the result of the matrix at each iteration

## Getting started

To launch the application you need to create a user for login, this can be done directly with the command:

```console
rails db:seed
```

After that, we need to allow ActionCable to work and update the page in real time, this can be done by running the following command directly in the rails console:

```console
ActionCable.server.broadcast("game_of_life", { grid: "New Grid!" })
```

That's it, now we are ready to play with our application, we can start the server and watch the Game Of Life!

```console
rails s
```
