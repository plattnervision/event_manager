require 'CSV'
contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
ary = []
contents.each do |row|
  phone = row[:homephone]
  phone.each do |a|
    if a != (0..10)
      a = ""
    end
  end
    puts phone
  #   ary.push(phone)
  # elsif phone[0] == "1" && phone.length > 10
  #   ary.push(phone)
  # end
end
puts ary
