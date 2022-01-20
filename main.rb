require_relative "lib/log_parser"
log_parser = LogParser.new("games.log")
puts log_parser.get_first_line
