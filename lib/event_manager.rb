require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

def clean_hours(date) #returns hours in a workable format
  real_date = DateTime.strptime(date.gsub(" ",""), '%m/%d/%y%H:%M')
  real_date.hour
end

def best_hour_2_advertise(hours)
  top_signups = Hash.new
  signup_hours = hours.uniq

  signup_hours.each do |something|
    top_signups[something] = hours.count(something)
  end

  signup_max = top_signups.values.max

  popular_days = top_signups.select{|k,v| v == signup_max}

  popular_days.each_key do |key|
    time_o_day = DateTime.strptime(key.to_s, '%H')
    puts time_o_day.strftime("Advertise @ %I:%M%P")
  end
end


puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id,form_letter)
end

puts "call to action finished"

puts "^ V_V ^"
puts "^ V_V ^"
puts "^ V_V ^"
puts "^ V_V ^"
puts "^ V_V ^"
puts "^ V_V ^"

puts "spiffy data analyzer begins to spin *beep**beep*"

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

raw_hours = []
contents.each do |row|
  date = row[:regdate]
  raw_hours.push(clean_hours(date))
end
best_hour_2_advertise(raw_hours)
