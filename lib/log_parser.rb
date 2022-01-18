class LogParser
    def initialize(file_name)
        @file_name = file_name
    end

    def print_first_line
        begin
            file = File.open(@file_name)
            file_data = file.readlines.map(&:chomp)
            first_line = file_data[0]
            file.close
            puts first_line
        rescue => exception
            puts "File not found"
        end
    end
end