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

def all_the_hours(number)
  real_date = DateTime.strptime(number.gsub(" ",""), '%m/%d/%y%H:%M')
  @raw_hours.push(real_date)
end

def hours_to_hash(number)
  top_signups[something] = raw_hours.count(something)
  best_hours
end

def best_hours(hash,hash2)
  top_signups = Hash.new
  hash.each do |something|
    top_signups[something] = hash2.count(something)
  end
  signup_max = top_signups.values.max


  popular_days = top_signups.select{|k,v| v == signup_max}

  popular_days.each_key do |key|
    time_o_day = DateTime.strptime(key.to_s, '%H')
    #puts time_o_day.strftime("Advertise @ %I:%M%P")
  end
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
@raw_hours = []
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id,form_letter)

  hour_of_day = row[:regdate]
  raw_hours = []
  raw_hours.push(all_the_hours(hour_of_day))


  signup_hours = raw_hours.uniq
  puts raw_hours

  #best_hours(signup_hours,raw_hours)
end
