require "log_parser"
describe LogParser do
    context "call print_first_line" do
        it "prints first line" do
            log_parser = LogParser.new("spec/fixtures/game_test.log")
            expect do
                log_parser.print_first_line
            end.to output("  0:00 ------------------------------------------------------------\n").to_stdout
        end
    end

    context "games.log does not exist" do
        it "print file not found" do
            log_parser = LogParser.new("game.log")
            expect do
                log_parser.print_first_line
            end.to output("File not found\n").to_stdout
        end
    end
end