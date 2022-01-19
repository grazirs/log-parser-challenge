class LogParser
  def initialize(file_name)
    @file_name = file_name
    raise "File not found" unless File.exists?(@file_name)
  end

  def get_first_line
    file = File.open(@file_name)
    file_data = file.readlines.map(&:chomp)
    first_line = file_data[0]
    file.close
    first_line
  end
end
