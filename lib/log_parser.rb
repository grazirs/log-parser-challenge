require "json"
class LogParser
    def initialize(file_path)
        @file_path = file_path
    end

    def get_log_data
        begin
            file = File.open(@file_path)
            file_data = file.readlines.map(&:chomp)
            lines_number = file_data.length
            file.close
            data = {:lines => lines_number}
            '"%{file_name}": %{json}' % {file_name:File.basename(@file_path), json:JSON.pretty_generate(data)}
        rescue => exception
            puts "File not found"
        end
    end
end
