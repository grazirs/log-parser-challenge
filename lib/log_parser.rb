# frozen_string_literal: true

require 'json'
# read and collect information of log.file
class LogParser
  KILL_LINE_REGEX = / \d{1,2}:\d{1,2} Kill: \d+ \d+ \d+: (.+) killed (.+) by .+/
  USER_LINE_REGEX = / \d{1,2}:\d{1,2} ClientUserinfoChanged: \d+ n\\(.+)\\t\\\d+\\model/
  def initialize(file_path)
    raise 'File not found' unless File.exist?(file_path)

    @file_path = file_path
    @file_data = File.readlines(@file_path, chomp: true)
    @players = []
    @kills = {}
  end

  def first_line
    @file_data.first
  end

  def log_data
    total_kills = 0
    @file_data.each do |line|
      total_kills += player_kills(line)
      player_info(line)
    end
    data = { lines: file_length, players: @players.uniq, kills: @kills, total_kills: }
    format('"%<file_name>s": %<json>s', file_name:, json: JSON.pretty_generate(data))
  end

  private

  def file_length
    @file_data.length
  end

  def file_name
    File.basename(@file_path)
  end

  def player_kills(line)
    return 0 unless line.match(KILL_LINE_REGEX)

    player_one = line[KILL_LINE_REGEX, 1]
    player_two = line[KILL_LINE_REGEX, 2]
    @players += [player_one, player_two].reject { |player| player == '<world>' }
    return 0 unless player_one != '<world>'

    @kills[player_one] = @kills.fetch(player_one, 0) + 1
    1
  end

  def player_info(line)
    return unless line.match(USER_LINE_REGEX)

    player = line[USER_LINE_REGEX, 1]
    @players.push(player)
  end
end
