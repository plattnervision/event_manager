require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
  # ^^ raw input of api response in array
  legislator_names = legislators.collect do |legislator|
    "#{legislator.first_name} #{legislator.last_name}" ## this is pulling out first_name and last_name but im not sure how
  end
  legislator_names.join(", ")
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  personal_letter = template_letter.gsub('FIRST_NAME',name) # creates a new copy of the form letter with gsub
  personal_letter.gsub!('LEGISLATORS',legislators) # alters the new copy with gsub!

  puts personal_letter
end
