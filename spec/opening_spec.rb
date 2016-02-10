require_relative '../lib/chess_openings/opening.rb'

RSpec.describe Opening do

  let(:sicilian) { Opening.new("Sicilian Defence", "B20", %w{e4 c5}) }
  let(:sicilian2) { Opening.new("Sicilian Defence", "B20", %w{e4 c5}) }
  let(:sicilian3) { Opening.new("Sicilian Defence", "B20", %w{e4 c5}) }
  let(:caro_kann) { Opening.new("Caro-Kann defence", "B12", %w{e4 c6 d4 d5}) }

  context '.new' do    
    it "should have name, eco code and moves" do
      expect(sicilian.name).to eq "Sicilian Defence"
      expect(sicilian.eco_code).to eq "B20"
      expect(sicilian.moves).to eq [:e4, :c5]
    end

    it "should accept symbols as moves" do
      expect(Opening.new("Sicilian Defence", "B20", %i{e4 c5}).moves).to eq [:e4, :c5]
    end
  end

  context '.to_h' do
    it "should return a hash of the instance variables" do
      result = { 
        "name" => "Caro-Kann defence",
        "eco_code" => "B12",
        "moves" => [:e4, :c6, :d4, :d5]
      }

      expect(caro_kann.to_h).to eq result
    end
  end

  context '==' do
    it "should give normal equality notion" do

      # Reflexivity
      expect(sicilian).to eq sicilian

      # Symetry
      expect(sicilian).to eq sicilian2
      expect(sicilian2).to eq sicilian

      # Transitivity
      expect(sicilian2).to eq sicilian3
      expect(sicilian).to eq sicilian3
      
      expect(caro_kann).to_not eq sicilian
    end
  end

  context ".to_pgn" do
    it "should transform moves into pgn string" do
      expect(sicilian.to_pgn).to eq "1. e4 c5"
      expect(caro_kann.to_pgn).to eq "1. e4 c6 2. d4 d5"
    end

  end
end