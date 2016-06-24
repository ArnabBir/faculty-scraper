require 'csv'
require 'mechanize'

bot = Mechanize.new
bot.follow_meta_refresh = true 
bot.verify_mode = OpenSSL::SSL::VERIFY_NONE

page = bot.get("http://www.seas.harvard.edu/faculty-research/people/ladder")
CSV.open("../data/harvard.csv", "a") do |csv|
  csv << ["NAME","EMAIL ID","PHONE NUMBER","WORK"]
end

num =  page.search(".field-name-title h2").count
for i in (0..num-1)
  name = page.search(".field-name-title h2")[i].text
  email = page.search(".field-name-field-email .field-item")[i].text
  begin
    phone = page.search(".field-name-field-phone .field-item")[i].text
  rescue
    phone = ""
  end  
  work = page.search(".field-name-field-primary-title .field-item")[i].text
  CSV.open("../data/harvard.csv", "a") do |csv|
    csv << [name,email,phone,work]
  end
  puts (i+1).to_s + "/" + num.to_s + " completed" 
end
