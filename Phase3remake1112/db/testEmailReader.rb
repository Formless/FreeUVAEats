require 'rubygems'
require 'mail'
require 'strscan'
require 'chronic'

=begin
/*
Mail.defaults do
  retriever_method :pop3, :address    => "pop.gmail.com",
                          :port       => 995,
                          :user_name  => 'pewpew4720@gmail.com',
                          :password   => 'nomnom4720',
                          :enable_ssl => true
end


mail = Mail.all #only gets unread emails
x = 0

while x < mail.length
  
  from = mail[x].from
  subject = mail[x].subject
  sendDate = mail[x].date.to_s 
  body = mail[x].body.decoded
  #puts sender
  puts from
  puts subject
  puts sendDate
  puts body

  x+=1
end
*/
=end
puts "-----"


#placeholder body

body="pizza testing word1 testing January 5 | 12 am"


dictQuery = nil

#figure out if there is a keyword in the body
File.open('dictionary.txt', 'r') do |f1|  
  while line = f1.gets    
    dictQuery = body.scan(/\b(?:#{line})\b/)
    if(dictQuery!=nil) #keyword found
      dictQuery = line
      break;
    end
  end  
end  

#if dictQuery = nil, no match --> throw away result
puts dictQuery

#now find date
date = nil

adjectives = ['next', 'this']
days = ['morning', 'night', 'tonight', 'Sunday', 'Sun', 'Monday', 'Mon', 'Tuesday', 'Tues', 'Wednesday', 'Wed', 'Thursday', 'Thurs', 'Friday', 'Fri', 'Saturday', 'Sat', 'Tomorrow', 'tomorrow', 'today', 'Today']
months = ['January', 'Jan', 'February', 'Feb', 'March', 'Mar', 'April', 'Apr', 'May', 'June', 'July', 'August', 'September', 'Aug', 'Sept', 'October', 'Oct', 'November', 'Nov', 'December', 'Dec']

x = 0
while(x==0)
  
  a = body.scan(/\d{1,2}\/\d{1,2}\/\d{2,4}/)
  if(!a.nil? && date.nil?)
    date = Chronic.parse(a)
  end
  
  a = body.scan(/\d{1,2}\-\d{1,2}\-\d{2,4}/)
  if(!a.nil? && date.nil?)
    date = Chronic.parse(a)
  end
  
  adjectives.each do |adj|
   days.each do |day|
     a = body.scan(/\b(?:#{adj})\s(?:#{day})\b/i)
     if(!a.nil? && date.nil?)
      date = Chronic.parse(a)
     end
   end   
  end
  
  months.each do |month|  
    a = body.scan(/\b#{month}\s\d{1,2}\b/i) 
    if(!a.nil? && date.nil?)
      date = Chronic.parse(a)
    end
  end
  
  months.each do |month|  
    a = body.scan(/\b#{month}\b/i)
    if(!a.nil? && date.nil?)
      date = Chronic.parse(a)
    end
  end

  x = date.strftime("%m/%d/%Y")
  x << " "
  
  #source: http://regexlib.com/REDetails.aspx?regexp_id=144
  b = body.scan(/((([0]?[1-9]|1[0-2])(:|\.)[0-5][0-9]((:|\.)[0-5][0-9])?( )?(AM|am|aM|Am|PM|pm|pM|Pm))|(([0]?[0-9]|1[0-9]|2[0-3])(:|\.)[0-5][0-9]((:|\.)[0-5][0-9])?))/)
  y = Chronic.parse(b)
  if(y!=nil)
      x << y.strftime("%H:%M")
  end

  b = body.scan(/([0]?[1-9]|1[0-2])?( )?(AM|am|aM|Am|PM|pm|pM|Pm)/)
  z = Chronic.parse(b)
  if(z!=nil)
    x << " " 
    x << z.strftime("%H:%M")
  end
  
  break;
  
end
date = Chronic.parse(x)

puts date

puts date.strftime("%m/%d/%Y")
puts date.strftime("%H:%M")


#Words: Whole word at the end of a line
#Whitespace permitted after the word
'\b%WORD%\s*$'

#Words: Whole word at the end of a line
'\b%WORD%$'

#Words: Whole word at the start of a line
'^%WORD%\b'

#Words: Whole word at the start of a line
#Whitespace permitted before the word
'^\s*%WORD%\b'


#Find date in formats of xx/xx/xxxx with dash,space, 2 or 4 digits year:
#puts a.scan(/\d.(\/|-|\.|\s).\d(\/|-|\.|\s)\d{2,4}/)
#puts body1
