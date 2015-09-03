load 'chess_openings.rb'

RSpec.describe ChessOpenings do
  subject(:subject) { ChessOpenings.new }

  context '.get_opening_from_pgn' do
    it "should return Opening based on pgn file" do
      
    end 

    it "should raise InvalidPGN if invalid pgn file" do
      
    end
  end

  context '.get_opening_from_string' do
    it "should return Opening from string formated like a pgn" do
      
    end
    
  end

  context '.get_opening_from_moves' do
    it "should return Opening based on the array of moves given" do
      
    end
  end

  context '.search_by_name' do
    it "should return array filled with Openings that match the name given" do
      
    end
  end

  context '.get_openings_that_start_with' do
    it "should return all Openings that start with the moves on the given array" do
      
    end
    
  end

  context '.get_all' do
    it "should return array with all Openings" do
      
    end
    
  end
end