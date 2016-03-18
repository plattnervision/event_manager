require 'CSV'
contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
ary = []
contents.each do |row|
  phone = row[:homephone]
  phone.gsub!("-","")
  phone.gsub!(" ","")
  phone.gsub!("(","")
  phone.gsub!(")","")
  phone.gsub!(".","")
  if phone.length > 10
    if phone[0] == 1
      phone.trim
    else
      phone = "0000000000"
    end
  elsif phone.length < 10
    phone = "0000000000"
  end
  puts phone
  #   ary.push(phone)
  # elsif phone[0] == "1" && phone.length > 10
  #   ary.push(phone)
  # end
end
puts ary
