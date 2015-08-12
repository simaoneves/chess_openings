load 'opening.rb'
load 'search_tree.rb'

RSpec.describe SearchTree  do

  context '.new' do

    let(:tree) { SearchTree.new }

    it 'should be empty' do
      expect(tree).to be_empty
    end

  end

  context '.size' do
    let(:tree) { SearchTree.new }
    let(:italian) { Opening.new("Italian Game", "A50", %w{e4 e5 Nf3 Nc6 Bc4 Bc5}) }
    let(:sicilian) { Opening.new("Sicilian Defence", "B20", %w{e4 c5}) }
    let(:caro_kahn) { Opening.new("Caro-Kahn Defence", "B10", %w{e4 c6 d4 d5}) }

    xit 'should return 0 when .new' do
      expect(tree.size).to eq 0
    end

    xit "should return the number of openings in the tree" do
      tree.insert italian, italian.moves
      tree.insert sicilian, sicilian.moves
      tree.insert caro_kahn, caro_kahn.moves
      expect(tree.size).to eq 3
    end
  end

  context '.insert' do
    let(:tree) { SearchTree.new }
    let(:italian) { Opening.new("Italian Game", "A50", %w{e4 e5 Nf3 Nc6 Bc4 Bc5}) }

    xit "should insert value into the tree" do

      expect(tree).to be_empty
      tree.insert italian, italian.moves
      expect(tree).to_not be_empty
      expect(tree.size).to eq 1
    end

  end

  context '.load_openings' do
    let(:tree) { SearchTree.new }
    it "should load all openings from file" do
      expect(tree).to be_empty
      tree.load_openings
      expect(tree).to_not be_empty
    end
  end


  
end