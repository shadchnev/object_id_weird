require_relative 'cell'
# gem 'pry-byebug'

class Grid
  @@iteration = 0
  GROUPS = [:row, :column, :box]
  GROUP_INDEX = (1..9).to_a

  attr_accessor :cells

  def initialize(input)
    initialize_cells(input)
  end

  def self.deep_copy(instance)
    Grid.new(instance.to_s)
  end

  def initialize_cells(normalised_input)
    @cells = []
    GROUP_INDEX.each do |row|
      GROUP_INDEX.each do |column|
        value = normalised_input[(row-1)*9 + (column-1)].to_i
        @cells << Cell.new(row, column, value)
      end
    end
  end

  def to_s
    cells.map{|cell| cell.to_s}.join('')
  end

  def cell_at(row, column)
    cells.find{|cell| cell.row == row && cell.column == column}
  end

  def solved?
    cells.all? {|cell| cell.solved?}
  end

  def group_candidates_for(current_cell, group)
    neighbours = cells.select{|cell| cell.send(group) == current_cell.send(group)}
    solved_neighbours = neighbours.select{|cell| cell.solved?}
    GROUP_INDEX - solved_neighbours.map{|cell| cell.value}
  end

  def candidates_for(current_cell)
    GROUPS.inject(GROUP_INDEX) do |candidates, group|
      candidates & group_candidates_for(current_cell, group)
    end
  end


  def solve()
    try = make_a_guess
  end

  def make_a_guess
    guess_grid = Grid.deep_copy(self)

    guess_cell = guess_grid.cells.find { |cell| !cell.solved?}
    return if guess_cell.nil?
    guess_candidates = candidates_for(guess_cell)

    call_id = rand(36**10).to_s(36)
    print "#{guess_candidates.length}:"
    print "#{call_id}:"
    print "#{guess_candidates.object_id}:"
    old = guess_candidates.object_id
    guess_candidates.each_with_index do |candidate,i|
      print "#{guess_candidates.object_id}:#{i}:"
      print "#{old != guess_candidates.object_id}:"
      print "#{call_id}:"
      @@iteration += 1 

      depth = Kernel.caller.select{|l| l.match /solve/}.count
      print "#{@@iteration}:"
      puts "#{depth}"
      guess_cell.value = candidate
      return true if guess_grid.solve
    end
    if guess_grid.solved?
      self.cells = guess_grid.cells 
    end
  end

  def solved_cell_count
    cells.select {|cell| cell.solved?}.count
  end

  def cells_in_group(group_number, group_type)
    cells.select{|cell| cell.send(group_type) == group_number }
  end

end

