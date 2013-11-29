module Kernel
  def puts(n)
  end
end

require_relative 'cell'
# gem 'pry-byebug'

class Grid
  @@foo = 0
  GROUPS = [:row, :column, :box]
  GROUP_INDEX = (1..9).to_a

  attr_accessor :cells

  def initialize(input)
    initialize_cells(input)
  end

  def self.deep_copy(instance)
    # Marshal.load(Marshal.dump(instance))
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
    puts "entering solve()"
    try = make_a_guess
  end

  def make_a_guess
    # puts 'make a guess'
    puts "entering make_a_guess()"
    p self
    guess_grid = Grid.deep_copy(self)
    # puts guess_grid.cells[0].inspect
    guess_cell = guess_grid.cells.find { |cell| !cell.solved?}
    return if guess_cell.nil?
    puts "Guess cell: #{guess_cell.object_id}: #{guess_cell.row}, #{guess_cell.column}. value: #{guess_cell.value.inspect}"
    # p guess_cell
    guess_candidates = candidates_for(guess_cell)
    puts "GUEST CANDIDATES:"
    puts guess_candidates.inspect + guess_candidates.object_id.to_s

    # print "before guess_candidates.each. Guess cell: #{guess_cell.object_id}: #{guess_cell.row}, #{guess_cell.column}. value: #{guess_cell.value.inspect}"

    print "#{guess_candidates.object_id}"
    
    guess_candidates.each do |candidate|
      # puts "inside guest_candidates.each. guess candidates: #{guess_candidates} for #{guess_cell.object_id}: #{guess_cell.row}, #{guess_cell.column}"
      print " v #{guess_candidates.object_id}"
      @@foo += 1 
      print " @ #{@@foo}\n"
      # print "#{old} v #{nu}"

      # puts guess_candidates.inspect + guess_candidates.object_id.to_s
      depth = Kernel.caller.select{|l| l.match /solve/}.count
      # print "Depth: #{depth}"
      # puts guess_grid.inspect
      # return nil if guess_candidates.empty?
      # guess_cell.value = guess_candidates.shift
      # break unless guess_grid.solve == nil #Try another candidate if that one lead to a dead end
      guess_cell.value = candidate
      return true if guess_grid.solve
    end
    if guess_grid.solved?
      puts "Guess grid solved"
      self.cells = guess_grid.cells 
    end
  end

  def solved_cell_count
    cells.select {|cell| cell.solved?}.count
  end

  def cells_in_group(group_number, group_type)
    cells.select{|cell| cell.send(group_type) == group_number }
  end


  def inspect
  end
end

