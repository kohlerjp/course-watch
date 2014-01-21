require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(open("http://northeastern.schedulizer.com/courses/boston+main/cs/1100/")) 
rows = page.xpath("//table/tbody/tr")
header = rows.shift

rows.xpath('td').map {|td| td.text }
rows.each do |row|

  puts "*********** NEW CLASS ***********"
  td = row.xpath('td')
  days = td[1]
  times = td[2]
  prof = td[3]
  crn = td[5]
  puts "Days: #{days.text}\nTimes: #{times}\nProfessor: #{prof}\nCRN: #{crn}"

end


