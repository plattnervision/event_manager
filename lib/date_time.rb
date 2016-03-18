require 'CSV'
contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
raw_days = []
contents.each do |row|
  date = row[:regdate]
  real_date = DateTime.strptime(date.gsub(" ",""), '%m/%d/%y%H:%M')
  raw_days.push(real_date.day)
end

signup_days = raw_days.uniq
top_signups = Hash.new
signup_days.each do |something|
  top_signups[something] = raw_days.count(something)
end
signup_max = top_signups.values.max
puts signup_max

popular_days = top_signups.select{|k,v| v == signup_max}
# # key => values
# # the key is the time of day, so ideally I want to know what the key is, not the value
#
# # put something that interprets what the hour is
# # interpret the hour
#
popular_days.each_key do |key|
  best_day = DateTime.strptime(key.to_s, '%d')
  puts best_day.strftime("Advertise on %A")
end


# summ = 0
# total = ary.each do |sum|
#   summ = summ + sum
# end
# average = summ/count
#
# puts average
