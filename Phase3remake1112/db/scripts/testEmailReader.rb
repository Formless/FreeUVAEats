require 'rubygems'
require 'mail'
require 'strscan'
require 'chronic'



Mail.defaults do
  retriever_method :pop3, :address    => "pop.gmail.com",
                          :port       => 995,
                          :user_name  => 'pewpew4720@gmail.com',
                          :password   => 'nomnom4720',
                          :enable_ssl => true
end


mail = Mail.all #only gets unread emails
x = 0
print "mail.length: " + mail.length.to_s

#put "Mail scan start!"

while x < mail.length
  puts "test run # " + x.to_s
  from = nil
  subject = nil
  body = nil
  chronicDate = nil
  e_date = nil
  e_time = nil
  
  from = mail[x].from
  subject = mail[x].subject
  #body = mail[x].body.decoded
  body = mail[x].parts[0].body.decoded
  #puts sender
  puts "From: " + from
  puts subject
  puts body
  chronicDate = searchBody(body) 
  if(chronicDate != nil)
    e_date = chronicDate.strftime("%m-%d-%Y") #date
    e_time = chronicDate.strftime("%H:%M") #time
    
  puts e_date.to_s
  puts e_time.to_s
    
  end
  
  
  #if you have all the variables, post to database
  if((from!=nil) && (subject!=nil) && (body!=nil) && (chronicDate!=nil))
    
  end
  
  x+=1
end


puts "-----"


#placeholder body



def searchBody(body)
  dictQuery = nil

  if((body.include? "pizza") || (body.include? "food") || (body.include? "donut") || (body.include? "cream") || (body.include? "free") || (body.include? "coffee"))
    dictQuery = "food"
    puts "done"
  end
  
  #if dictQuery is empty, no match --> throw away result
  if(dictQuery==nil)
    return nil
  end
  puts "final dictQuery: " + dictQuery
  
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
  
    if (!date.nil?)
      x = date.strftime("%m/%d/%Y")
      x << " "
    end 
    
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
  
  
  
  #TODO: Invalid date
  puts date
  
  puts date.strftime("%m-%d-%Y") #date
  puts date.strftime("%H:%M") #time
  return date
end

#e_body = "food word1 testing January 5th at 8 pm"
#puts e_body 
#searchBody(e_body)


#Words: Whole word at the end of a line
#Whitespace permitted after the word
#'\b%WORD%\s*$'

#Words: Whole word at the end of a line
#'\b%WORD%$'

#Words: Whole word at the start of a line
#'^%WORD%\b'

#Words: Whole word at the start of a line
#Whitespace permitted before the word
#'^\s*%WORD%\b'


#Find date in formats of xx/xx/xxxx with dash,space, 2 or 4 digits year:
#puts a.scan(/\d.(\/|-|\.|\s).\d(\/|-|\.|\s)\d{2,4}/)
#puts body1
