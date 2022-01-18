require "log_parser"
describe LogParser do
    context "call print_log_data" do
        it "prints lines number" do
            log_parser = LogParser.new("spec/fixtures/game_test.log")
            output = log_parser.get_log_data
            expect(output).to start_with('"game_test.log":')
            json_data = JSON.parse(output[17, output.length-1])
            expect(json_data['lines']).to eq(10)
        end
    end

    context "games.log does not exist" do
        it "print file not found" do
            log_parser = LogParser.new("game.log")
            expect do
                log_parser.get_log_data
            end.to output("File not found\n").to_stdout
        end
    end
end
