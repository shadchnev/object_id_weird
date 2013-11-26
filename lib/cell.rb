class Cell
  attr_reader :row, :column
  attr_accessor :value

  def initialize(row:row, column:column, value:value)
    @row = row
    @column = column
    @value = value
  end

  def to_s
    @value.to_s
  end

  def solved?
    @value != 0
  end

  def box
    (((row + 2)/3)*3 + (column + 2)/3 - 3)
  end
end