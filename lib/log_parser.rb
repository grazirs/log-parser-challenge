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
    @file.close
    data = {:lines => self.file_length}
    '"%{file_name}": %{json}' % {file_name: self.file_name, json:JSON.pretty_generate(data)}
  end

  private
  def file_length
    @file_data.length
  end

  def file_name
    File.basename(@file_path)
  end
end
