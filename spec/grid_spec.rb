require 'grid'

describe Grid do 
    let(:testinput){ 
     "+---+---+---+
      |...|8.9|...|
      |836|5..|17.|
      |45.|..3|.62|
      +---+---+---+
      |7.1|.4.|.9.|
      |36.|...|58.|
      |.2.|78.|4.1|
      +---+---+---+
      |1..|6.7|9..|
      |.92|...|..5|
      |.7.|.12|.43|
      +---+---+---+"
    }
    let(:grid){Grid.new(testinput)}
    let(:unsolved_cell){grid.cell_at(row:1, column:1)}
    let(:duff_solution){"794746223874651872635419371982736429313645192736491278346192635412937462398457456"}

  context 'initialization' do

    it 'should load a graphical input correctly' do
      expect(grid.to_s).to eq "000809000836500170450003062701040090360000580"\
                            + "020780401100607900092000005070012043"
    end

    it 'should raise an error if input is the wrong length' do
      expect {Grid.new("123...23445...")}.to raise_error(RuntimeError) 
    end

    it 'should know what its cells are' do
      expect(grid.cells.length).to eq(81) 
    end

    it 'should know when it is not solved' do
      expect(grid).not_to be_solved 
    end
  end

  context 'should know the candidate values' do

    it "from its row, if not solved" do
      expect(grid.group_candidates_for(unsolved_cell, :row).sort).to eq([1,2,3,4,5,6,7]) 
    end

    it "from its column, if not solved" do
      expect(grid.group_candidates_for(unsolved_cell, :column).sort).to eq([2,5,6,9]) 
    end

    it "from its box, if not solved" do
      expect(grid.group_candidates_for(unsolved_cell, :box).sort).to eq([1,2,7,9]) 
    end
  
    it 'for the current cell, if not solved' do
      expect(grid.candidates_for(unsolved_cell).sort).to eq([2]) 
    end
  end

  context 'solver' do
    it 'should set cell to a number if that number is the only candidate' do
      expect(unsolved_cell.value).to eq 0
      grid.solve_cell_at(row:1, column:1)
      expect(unsolved_cell.value).to eq 2
    end

    it 'should solve the puzzle, if all cells are soluble' do
      grid.solve
      expect(grid).to be_solved 
    end

  end

   context 'solved?' do
    it 'should verify the solution is correct' do
      grid.solve
      expect(grid).to be_valid
    end

    it 'should verify an incorrect solution is incorrect' do
      bad_grid = Grid.new(duff_solution)
      expect(bad_grid).to_not be_valid
    end
  
  end

end # of describe