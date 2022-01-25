require "log_parser"

describe LogParser do
  describe "#get_first_line" do
    it "gets first line" do
      log_parser = LogParser.new("spec/fixtures/game_test.log")
      first_line = log_parser.get_first_line
      expect(first_line).to eq("  0:00 ------------------------------------------------------------")
    end
  end

  describe "#initialize" do
    it "print file not found" do
      expect { LogParser.new("game.log") }.to raise_error("File not found")
    end
  end
  
  describe "#get_log_data" do
    it "prints lines number" do
      log_parser = LogParser.new("spec/fixtures/game_test.log")
      output = log_parser.get_log_data
      expect(output).to start_with('"game_test.log":')
      json_data = JSON.parse(output[17, output.length-1])
      expect(json_data['lines']).to eq(52)
      expect(json_data['players']).to eq(["Isgalamido", "<world>", "Dono da Bola", "Mocinha", "UnnamedPlayer"])
    end
  end
end
