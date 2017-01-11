require_relative '../lib/chess_openings/search_tree.rb'

RSpec.describe SearchTree  do

  context '.new' do
    let(:tree) { SearchTree.new }

    it 'should be empty' do
      expect(tree).to be_empty
    end
  end

  context '==' do
    let(:tree) { SearchTree.new }
    let(:tree2) { SearchTree.new }

    it "should return true if 2 trees are equal" do
      expect(tree).to eq tree2
    end

    it "should return false if trees are not equal" do
      tree.root.nodes["1"] = "error"
      expect(tree).to_not eq tree2

      tree2.root.nodes["1"] = "error"
      expect(tree).to eq tree2

      tree.root.nodes["2"] = "one"
      tree2.root.nodes["2"] = "another"
      expect(tree).to_not eq tree2
    end
  end

  context '.insert' do
    let(:tree) { SearchTree.new }
    let(:tree2) { SearchTree.new }

    it "should receive moves as symbols" do
      tree.insert %i{e4 c6 d4 d5}, "Caro-Kahn Defence"
      expect(tree).to_not be_empty
      expect(tree.root.nodes[:e4].nodes[:c6].nodes[:d4].nodes[:d5].value).to eq "Caro-Kahn Defence"
    end

    it "should insert value into the tree with an array" do
      expect(tree).to be_empty
      tree.insert %w{e4 c6 d4 d5}, "Caro-Kahn Defence"
      expect(tree).to_not be_empty
      expect(tree.root.nodes[:e4].nodes[:c6].nodes[:d4].nodes[:d5].value).to eq "Caro-Kahn Defence"


      expect(tree2).to be_empty
      tree2.insert ["e4"], "King's pawn game"
      expect(tree2).to_not be_empty
      expect(tree2.root.nodes[:e4].value).to eq "King's pawn game"
    end

    it "should insert values independent of their order" do

      tree.insert ["e4"], "King's Pawn Game"
      tree.insert %w{e4 c6 d4 d5}, "Caro-Kahn Defence"

      tree2.insert %w{e4 c6 d4 d5}, "Caro-Kahn Defence"
      tree2.insert ["e4"], "King's Pawn Game"

      expect(tree).to eq tree2
    end
  end

  context '.size' do
    let(:tree) { SearchTree.new }

    it "should return the number of openings in the tree" do
      expect(tree.size).to eq 0
      tree.insert ["e4"], "King's Pawn Game"
      tree.insert %w{e4 c5}, "Sicilian Defense"
      tree.insert %w{e4 c6 d4 d5}, "Caro-Kahn Defence"
      expect(tree.size).to eq 3
    end
  end

  context '.search' do
    let(:tree) { SearchTree.new }

    it "should return the value stored in the tree" do
      tree.insert ["e4"], "King's Pawn Game"
      tree.insert %w{e4 c5}, "Sicilian Defense"
      tree.insert %w{e4 c6 d4 d5}, "Caro-Kahn Defence"

      expect(tree.search(["e4"])).to eq "King's Pawn Game"
      expect(tree.search(["e4", "c5"])).to eq "Sicilian Defense"
      expect(tree.search(["e4", "c6", "d4", "d5"])).to eq "Caro-Kahn Defence"

    end
  end

  context '.search_all_with_moves' do
    let(:tree) { SearchTree.new }

    it "should return array with all openings that start with the moves given" do
      tree.insert ["e4"], "King's Pawn Game"
      tree.insert %w{e4 c5}, "Sicilian Defense"
      tree.insert %w{e4 c6 d4 d5}, "Caro-Kahn Defence"
      tree.insert %w{e4 c6 d4 d5 Nf3}, "Caro-Kahn Defence Knight"

      expect(tree.search_all_with_moves(["e4"])).to be_a Array
      expect(tree.search_all_with_moves(["e4"]).count).to eq 4
      expect(tree.search_all_with_moves(%w{e4 c6 d4 d5}).count).to eq 2
      expect(tree.search_all_with_moves(%w{e4 c6 d4 d5})).to include("Caro-Kahn Defence")
      expect(tree.search_all_with_moves(%w{e4 c6 d4 d5})).to_not include("King's Pawn Game")
    end
  end

  context '.get_moves_in_depth' do
    let(:tree) { SearchTree.new }

    it "should return 2 openings if num = 1" do
      tree.insert ["e4"], "King's Pawn Game"
      tree.insert ["a4"], "Test"
      tree.insert %w{e4 c5}, "Sicilian Defense"
      tree.insert %w{e4 c6 d4 d5}, "Caro-Kahn Defence"

      expect(tree.get_moves_in_depth(1).size).to eq 2
      expect(tree.get_moves_in_depth(1)).to include("King's Pawn Game")
      expect(tree.get_moves_in_depth(1)).to include("Test")
    end

    it "should return empty array if num > depth" do
      tree.insert ["e4"], "King's Pawn Game"
      tree.insert ["a4"], "Test"
      tree.insert %w{e4 c5}, "Sicilian Defense"
      tree.insert %w{e4 c6 d4 d5}, "Caro-Kahn Defence"

      expect(tree.get_moves_in_depth(20)).to eq []
      expect(tree.get_moves_in_depth(20).size).to eq 0
    end
  end
  
end
