# frozen_string_literal: true

require 'json'
# read and collect information of log.file
class LogParser
  def initialize(file_path)
    @file_path = file_path
    raise 'File not found' unless File.exist?(@file_path)

    file = File.open(@file_path)
    @file_data = file.readlines.map(&:chomp)
    file.close
  end

  def first_line
    @file_data[0]
  end

  def log_data
    players = []
    kills = {}
    total_kills = 0
    @file_data.each do |line|
      total_kills += player_kills(line, players, kills)
      player_info(line, players)
    end
    data = { lines: file_length, players: players.uniq, kills:, total_kills: }
    format('"%<file_name>s": %<json>s', file_name:, json: JSON.pretty_generate(data))
  end

  private

  def file_length
    @file_data.length
  end

  def file_name
    File.basename(@file_path)
  end

  def player_kills(line, players, kills)
    return 0 unless line.match(/ \d{1,2}:\d{1,2} Kill: \d+ \d+ \d+: .+ killed .+by .+/)

    player_one = line[line.rindex(':') + 2..line.index('killed') - 2]
    player_two = line[line.index('killed') + 7..line.rindex('by') - 2]
    players.push(player_one)
    players.push(player_two)
    kills[player_one] = (kills[player_one] || 0) + 1
    1
  end

  def player_info(line, players)
    return unless line.match(/ \d{1,2}:\d{1,2} ClientUserinfoChanged: \d+ n\\.+\\t\\\d+\\model/)

    player = line[line.index('n\\') + 2..line.index('\\t') - 1]
    players.push(player)
  end
end
