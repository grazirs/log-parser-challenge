# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'log_parser'

describe LogParser do
  describe '#first_line' do
    context 'call first_line' do
      it 'gets first line' do
        log_parser = LogParser.new('spec/fixtures/game_test.log')
        first_line = log_parser.first_line
        expect(first_line).to eq('  0:00 ------------------------------------------------------------')
      end
    end
  end

  describe '#when file does not exist' do
    context 'games.log does not exist' do
      it 'print file not found' do
        expect { LogParser.new('game.log') }.to raise_error('File not found')
      end
    end
  end

  describe '#log_data' do
    context 'call print_log_data' do
      it 'prints lines number' do
        log_parser = LogParser.new('spec/fixtures/game_test.log')
        output = log_parser.log_data
        expect(output).to start_with('"game_test.log":')
        json_data = JSON.parse(output[17, output.length - 1])
        expect(json_data['lines']).to eq(52)
        expect(json_data['players']).to eq(['Isgalamido', '<world>', 'Dono da Bola', 'Mocinha', 'UnnamedPlayer'])
        expect(json_data['kills']).to eq({ '<world>' => 4, 'Isgalamido' => 3 })
        expect(json_data['total_kills']).to eq(7)
      end
    end
  end
end
