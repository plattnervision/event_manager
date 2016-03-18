require "csv" # loads that class baby
puts "EventManager initialized"

# contents is a special csv class, this line does the same thing as file.open but maybe splits that shit up
contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
# puts contents.class = CSV
# puts contents.methods.count
# cont = contents.read
# puts cont.class CSV::table - unlike the row whcih is CSV::row this returns the entire thing, which makes sense
# puts cont.methods.count
puts :symbol.class
contents.each do |row| # row is another special csv::row class (WUT)
  name = row[:first_name] # accepts positions like its an array. so, my guess
  zipcode = row[:zipcode]
  puts "#{name} #{zipcode}"     # this just auto string.splits(",") a
end
# This file here walked through requiring gems / classes (require "class")
# it also showed how to use the CSV class which has its own special methods
# some cool things - it has built in options that allow for designating headers
# and also for converting those headers into symbols
# If a header: :true, header_converters: :symbols it is possible to call those
# for each row
