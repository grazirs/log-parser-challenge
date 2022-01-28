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

  context 'when file does not exist' do
    it 'print file not found' do
      expect { LogParser.new('game.log') }.to raise_error('File not found')
    end
  end

  describe '#log_data' do
    before do
      log_parser = LogParser.new('spec/fixtures/game_test.log')
      @output = log_parser.log_data
      @json_data = JSON.parse(@output[17, @output.length - 1])
    end

    it 'prints file name' do
      expect(@output).to start_with('"game_test.log":')
    end

    it 'prints lines count' do
      expect(@json_data['lines']).to eq(52)
    end

    it 'prints players list' do
      expect(@json_data['players']).to eq(['Isgalamido', 'Dono da Bola', 'Mocinha', 'UnnamedPlayer'])
    end

    it 'prints individual kills count ' do
      expect(@json_data['kills']).to eq({ 'Isgalamido' => 3 })
    end

    it 'prints total kills' do
      expect(@json_data['total_kills']).to eq(3)
    end
  end
end
