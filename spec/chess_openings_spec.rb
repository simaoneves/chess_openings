require_relative '../lib/chess_openings.rb'

RSpec.describe ChessOpenings do

  subject(:subject) { ChessOpenings.new }
  let(:sicilian) { Opening.new("Sicilian defence", "B20", %w{e4 c5}) }
  let(:kings_pawn) { Opening.new("King's pawn game", "C20", %i{e4 e5}) }
  let(:caro_kann) { Opening.new("Caro-Kann defence", "B12", %w{e4 c6 d4 d5}) }
  let(:ruy_lopez_exchange) { Opening.new("Ruy Lopez, exchange variation", "C68", %w{e4 e5 Nf3 Nc6 Bb5 a6 Bxc6}) }

  context '.from_pgn' do
    it "should return Opening based on pgn file" do
      expect(subject.from_pgn("spec/pgn_files_for_tests/game_1.pgn").name).to eq "Bishop's opening"
    end 

    it "should raise LoadError if file does not exist" do
      expect{subject.from_pgn("does_not_exist")}.to raise_error(LoadError)
    end

    it "should raise InvalidPGNError if invalid pgn file" do
      expect{subject.from_pgn("spec/pgn_files_for_tests/invalid_pgn.pgn")}.to raise_error(InvalidPGNError)
    end
  end

  context '.from_string' do
    it "should return Opening from string formated like a pgn" do
      expect(subject.from_string("1.e4 c5")).to eq sicilian
      expect(subject.from_string("1. e4 c5")).to eq sicilian
      expect(subject.from_string("1.e4 e5 2.Nf3 Nc6 3. Bb5 a6 4. Bxc6")).to eq ruy_lopez_exchange
    end
    
  end

  context '.from_moves' do
    it "should return Opening based on the array of moves given" do
      expect(subject.from_moves(["e4", "c6", "d4", "d5"])).to eq caro_kann
    end

    it "should accept symbols as moves" do
      expect(subject.from_moves([:e4, :c6, :d4, :d5])).to eq caro_kann
    end
  end

  context '.with_name' do
    it "should return array filled with Openings that match the name given" do
      expect(subject.with_name("sicilian")).to be_a Array
      expect(subject.with_name("sicilian")).to include(sicilian)
      expect(subject.with_name("sicilian")).to_not include(ruy_lopez_exchange)
      expect(subject.with_name("no_opening_found")).to be_empty
    end
  end

  context '.that_start_with' do
    it "should return all Openings that start with the moves on the given array" do
      expect(subject.that_start_with(%w{e4 c5})).to be_a Array  
      expect(subject.that_start_with(%w{e4})).to include(ruy_lopez_exchange)
      expect(subject.that_start_with(%w{e4})).to include(sicilian)
      expect(subject.that_start_with(%w{e4 c5 d4})).to_not include(sicilian)
      expect(subject.that_start_with(%w{e4})).to include(caro_kann)
      expect(subject.that_start_with(%w{e4 e5 Nf3 Nc6})).to include(ruy_lopez_exchange)
      expect(subject.that_start_with(%w{e4 e5 Nf3 Nc6})).to_not include(caro_kann)
      expect(subject.that_start_with(%w{e4 e5 Nf3 Nc6})).to_not include(caro_kann)
    end

    it "should accept symbols as moves" do
      expect(subject.that_start_with(%i{e4 e5 Nf3 Nc6})).to_not include(caro_kann)
    end
    
  end

  context '.get_all' do
    it "should return array with all Openings" do
      num_opening = subject.list.size
      expect(subject.get_all).to be_a Array
      expect(subject.get_all.size).to eq num_opening
    end
  end

  context '.from_fen' do
    it "should return array of all openings that may match the FEN string given" do
      expect(subject.from_fen('rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq e6 0 1')).to be_a Array
      expect(subject.from_fen('rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq e6 0 1').size).to eq 1
      expect(subject.from_fen('rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq e6 0 1').first).to eq kings_pawn
      expect(subject.from_fen('rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq e6 0 1')).to_not include(caro_kann)
    end
  end
end
