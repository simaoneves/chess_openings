load 'chess_openings.rb'

RSpec.describe ChessOpenings do

  subject(:subject) { ChessOpenings.new }
  let(:sicilian) { Opening.new("Sicilian defence", "B20", %w{e4 c5}) }
  let(:caro_kann) { Opening.new("Caro-Kann defence", "B12", %w{e4 c6 d4 d5}) }
  let(:ruy_lopez_exchange) { Opening.new("Ruy Lopez, exchange variation", "C68", %w{e4 e5 Nf3 Nc6 Bb5 a6 Bxc6}) }

  context '.get_opening_from_pgn' do
    it "should return Opening based on pgn file" do
      expect(subject.get_opening_from_pgn("spec/pgn_files_for_tests/game_1.pgn").name).to eq "Bishop's opening"
    end 

    it "should raise LoadError if file does not exist" do
      expect{subject.get_opening_from_pgn("does_not_exist")}.to raise_error(LoadError)
    end

    it "should raise InvalidPGNError if invalid pgn file" do
      expect{subject.get_opening_from_pgn("spec/pgn_files_for_tests/invalid_pgn.pgn")}.to raise_error(InvalidPGNError)
    end
  end

  context '.get_opening_from_string' do
    it "should return Opening from string formated like a pgn" do
      expect(subject.get_opening_from_string("1.e4 c5")).to eq sicilian
      expect(subject.get_opening_from_string("1. e4 c5")).to eq sicilian
      expect(subject.get_opening_from_string("1.e4 e5 2.Nf3 Nc6 3. Bb5 a6 4. Bxc6")).to eq ruy_lopez_exchange
    end
    
  end

  context '.get_opening_from_moves' do
    it "should return Opening based on the array of moves given" do
      expect(subject.get_opening_from_moves(["e4", "c6", "d4", "d5"])).to eq caro_kann
    end
  end

  context '.search_by_name' do
    it "should return array filled with Openings that match the name given" do
      expect(subject.search_by_name("sicilian")).to be_a Array
      expect(subject.search_by_name("sicilian")).to include(sicilian)
      expect(subject.search_by_name("sicilian")).to_not include(ruy_lopez_exchange)
      expect(subject.search_by_name("no_opening_found")).to be_empty
    end
  end

  context '.get_openings_that_start_with' do
    it "should return all Openings that start with the moves on the given array" do
      expect(subject.get_openings_that_start_with(%w{e4 c5})).to be_a Array  
      expect(subject.get_openings_that_start_with(%w{e4})).to include(ruy_lopez_exchange)
      expect(subject.get_openings_that_start_with(%w{e4})).to include(sicilian)
      expect(subject.get_openings_that_start_with(%w{e4})).to include(caro_kann)
      expect(subject.get_openings_that_start_with(%w{e4 e5 Nf3 Nc6})).to include(ruy_lopez_exchange)
      expect(subject.get_openings_that_start_with(%w{e4 e5 Nf3 Nc6})).to_not include(caro_kann)
    end
    
  end

  context '.get_all' do
    it "should return array with all Openings" do
      num_opening = subject.list.size
      expect(subject.get_all).to be_a Array
      expect(subject.get_all.size).to eq num_opening
    end
    
  end
end