# frozen_string_literal: true

require_relative 'lib/log_parser'
log_parser = LogParser.new('games.log')
first_line = log_parser.first_line
data = log_parser.log_data
puts first_line
puts data
