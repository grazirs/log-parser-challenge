require "log_parser"
describe LogParser do
  context "call get_first_line" do
    it "gets first line" do
      log_parser = LogParser.new("spec/fixtures/game_test.log")
      first_line = log_parser.get_first_line
      expect(first_line).to eq("  0:00 ------------------------------------------------------------")
    end
  end

  context "games.log does not exist" do
    it "print file not found" do
      expect { LogParser.new("game.log") }.to raise_error("File not found")
    end
  end
end
