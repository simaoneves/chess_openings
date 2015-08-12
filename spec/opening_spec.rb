load 'opening.rb'

RSpec.describe Opening do

  context '.new' do
    let(:sicilian) { Opening.new("Sicilian Defence", "B20", %w{e4 c5}) }
    
    it "should have name, eco code and moves" do
      expect(sicilian.name).to eq "Sicilian Defence"
      expect(sicilian.eco_code).to eq "B20"
      expect(sicilian.moves).to eq ["e4", "c5"]
    end
  end

  context '.to_h' do
    let(:caro_kahn) { Opening.new("Caro-Kahn Defence", "B10", %w{e4 c6 d4 d5}) }

    it "should return a hash of the instance variables" do
      result = { 
        "name" => "Caro-Kahn Defence",
        "eco_code" => "B10",
        "moves" => ["e4", "c6", "d4", "d5"]
      }

      expect(caro_kahn.to_h).to eq result
    end
  end

  context '==' do
    let(:sicilian) { Opening.new("Sicilian Defence", "B20", %w{e4 c5}) }
    let(:sicilian2) { Opening.new("Sicilian Defence", "B20", %w{e4 c5}) }
    let(:sicilian3) { Opening.new("Sicilian Defence", "B20", %w{e4 c5}) }
    let(:caro_kahn) { Opening.new("Caro-Kahn Defence", "B10", %w{e4 c6 d4 d5}) }

    it "should give normal equality notion" do

      # Reflexivity
      expect(sicilian).to eq sicilian

      # Symetry
      expect(sicilian).to eq sicilian2
      expect(sicilian2).to eq sicilian

      # Transitivity
      expect(sicilian2).to eq sicilian3
      expect(sicilian).to eq sicilian3
      
      expect(caro_kahn).to_not eq sicilian
    end
  end
end