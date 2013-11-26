require 'cell'

class Grid
  
  attr_reader :cells

  def initialize(input)
    normalised_input = input_interpreter(input)
    raise "Invalid input" if !(normalised_input.length == 81)
    initialize_cells(normalised_input)
  end

  def initialize_cells(normalised_input)
    @cells = []
    (1..9).each do |row|
      (1..9).each do |column|
        value = normalised_input[(row-1)*9 + (column-1)].to_i
        @cells << Cell.new(row:row, column:column, value:value)
      end
    end
  end

  def input_interpreter(input)
    input.gsub(/[^0-9.]/,'').gsub(/\./,'0') # magic
  end

  def to_s
    cells.map{|cell| cell.to_s}.join('')
  end

  def cell_at(row:row, column:column)
    cells.find{|cell| cell.row == row && cell.column == column}
  end

  def solved?
    cells.all? {|cell| cell.solved?}
  end

  def group_candidates_for(current_cell, group)
    neighbours = cells.select{|cell| cell.send(group) == current_cell.send(group)}
    solved_neighbours = neighbours.select{|cell| cell.solved?}
    (1..9).to_a - solved_neighbours.map{|cell| cell.value}
  end

  def candidates_for(current_cell)
    [:row, :column, :box].inject((1..9).to_a) do |candidates, group|
      candidates & group_candidates_for(current_cell, group)
    end
  end

  def solve_cell_at(row:row, column:column)
    solve_cell(cell_at(row:row, column:row))
  end

  def solve_cell(current_cell)
    possibilities = candidates_for(current_cell)
    current_cell.value = possibilities.first if possibilities.length == 1 
  end

end

