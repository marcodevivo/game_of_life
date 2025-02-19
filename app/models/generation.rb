class Generation
  attr_accessor :number_of_generation, :rows, :cols, :initial_state, :grid

  def initialize(input_reader)
    @number_of_generation = input_reader.generation
    @rows, @cols = input_reader.grid_size
    @initial_state = input_reader.grid_state
    @grid = Grid.new(@rows, @cols, @initial_state)
  end

end
