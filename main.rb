require_relative "lib/log_parser"
log_parser = LogParser.new("games.log")
first_line = log_parser.get_first_line
data = log_parser.get_log_data
puts first_line
puts data
