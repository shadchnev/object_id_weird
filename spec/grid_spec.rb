require 'grid'

describe Grid do 
  context 'initialization' do
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

    
    # expect(grid(0,0).solved?).to be_false
    # expect(grid(0,4).solved?).to be_true
    # expect(grid())
  

  end
end