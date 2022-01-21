require "json"
class LogParser
    def initialize(file_path)
        @file_path = file_path
        raise "File not found" unless File.exists?(@file_path)
    end

    def get_log_data
      file = File.open(@file_path)
      file_data = file.readlines.map(&:chomp)
      lines_number = file_data.length
      players = []
      file_data.each do |line|
        if line.match(/ \d{1,2}:\d{1,2} Kill: \d+ \d+ \d+: .+ killed .+by .+/)
          player_one = line[line.rindex(":")+2..line.index("killed")-2]
          player_two = line[line.index("killed")+7..line.rindex("by")-2]
          players.push(player_one)
          players.push(player_two)
        end
        if line.match(/ \d{1,2}:\d{1,2} ClientUserinfoChanged: \d+ n\\.+\\t\\\d+\\model/)
          player = line[line.index("n\\")+2..line.index("\\t")-1]
          players.push(player)
        end
      end
      file.close
      data = {:lines => lines_number, :players => players.uniq}
      '"%{file_name}": %{json}' % {file_name:File.basename(@file_path), json:JSON.pretty_generate(data)}
    end
end



# const data = ['ciao 1', 'amore', 'dove', 'ciao2', 'mare'];

# data.foreach((element){
#   if (element.contains('ciao'))
#     console.log(element);
  
# });