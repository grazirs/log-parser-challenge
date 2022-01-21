require "json"
class LogParser
  def initialize(file_path)
    @file_path = file_path
    raise "File not found" unless File.exists?(@file_path)
    @file = File.open(@file_path)
    @file_data = @file.readlines.map(&:chomp)
  end

  def get_first_line
    first_line = @file_data[0]
  end

  def get_log_data
    lines_number = @file_data.length
    @file.close
    data = {:lines => lines_number}
    '"%{file_name}": %{json}' % {file_name:File.basename(@file_path), json:JSON.pretty_generate(data)}
  end
end
