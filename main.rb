require_relative "lib/log_parser"
log_parser = LogParser.new("games.log")
data = log_parser.get_log_data
puts data 
