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
'
  

  end
end