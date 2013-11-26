require 'cell'
require 'grid'

testinput = "000809000836500170450003062701040090360000580"\
                            + "020780401100607900092000005070012043"

describe Cell do

  let(:grid){Grid.new(testinput)}
  let(:unsolved_cell){grid.cell_at(row:1, column:1)}
  
  it 'should know which row it is in' do
    expect(grid.cell_at(row:5, column:7).row).to eq(5) 
  end

  it "should know its value" do
    expect(grid.cell_at(row:5, column:7).value).to eq(5) 
  end

  it 'should know what box it\'s in' do
    expect(grid.cell_at(row:5, column:7).box).to eq([2,3])
  end

  it "should know the candidate values from its row, if not solved" do
    expect(grid.candidates_for(unsolved_cell, :row).sort).to eq([1,2,3,4,5,6,7]) 
  end

  it "should know the candidate values from its column, if not solved" do
    expect(grid.candidates_for(unsolved_cell, :column).sort).to eq([2,5,6,9]) 
  end

  it "should know the candidate values from its box, if not solved" do
    expect(grid.candidates_for(unsolved_cell, :box).sort).to eq([1,2,7,9]) 
  end

end