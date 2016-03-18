puts "EventManager initialized"

# read the file and split it into an array of strings based on line
lines = File.readlines "event_attendees.csv"
# takes the array lines and splits each |line| into an array separated by ,
lines.each_with_index do |line,index|
  next if index == 0
  columns = line.split(",")
  # assigns name to the array column @2 which is the names row
  name = columns[2]
  puts name
end
puts lines[1]
