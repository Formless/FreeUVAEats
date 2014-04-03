require 'rubygems'
require 'gmail'
require 'strscan'
require 'chronic'
require 'sanitize'

from = nil
subject = nil
e_date = nil
e_time = nil
body = nil

def searchBody(body)
  dictQuery = nil

  if((body.include? "pizza") || (body.include? "PIZZA") || (body.include? "FREE") || (body.include? "food") || (body.include? "donut") || (body.include? "cream") || (body.include? "free") || (body.include? "coffee"))
    dictQuery = "food"
#    puts "done"
  end

  #if dictQuery is empty, no match --> throw away result  
  if(dictQuery==nil)
    return nil
  end
# puts "final dictQuery: " + dictQuery
  
  #now find date
  e_date = nil
  info = Array.new
  
  
  adjectives = ['next', 'this']
  days = ['morning', 'night', 'tonight', 'Tonight', 'Sunday', 'Sun', 'Monday', 'Mon', 'Tuesday', 'Tues', 'Wednesday', 'Wed', 'Thursday', 'Thurs', 'Friday', 'Fri', 'Saturday', 'Sat', 'Tomorrow', 'tomorrow', 'today', 'Today']
  months = ['January', 'Jan', 'February', 'Feb', 'March', 'Mar', 'April', 'Apr', 'May', 'June', 'July', 'August', 'September', 'Aug', 'Sept', 'October', 'Oct', 'November', 'Nov', 'December', 'Dec']
  
  x = 0
  while(x==0)
    
    a = body.scan(/\d{1,2}\/\d{1,2}\/\d{2,4}/)
    if(!a.nil? && e_date.nil?)
      e_date = Chronic.parse(a)
    end
    puts "a1: " + a.to_s
    puts "chronic1: " + e_date.to_s
    
    a = body.scan(/\d{1,2}\-\d{1,2}\-\d{2,4}/)
    if(!a.nil? && e_date.nil?)
      e_date = Chronic.parse(a)
    end
    puts "a2: " + a.to_s
    puts "chronic2: " + e_date.to_s
    
    adjectives.each do |adj|
     days.each do |day|
       a = body.scan(/\b(?:#{adj})\s(?:#{day})\b/i)
       if(!a.nil? && e_date.nil?)
        e_date = Chronic.parse(a)
       end
     end   
    end
    puts "a3: " + a.to_s
    puts "chronic3: " + e_date.to_s
    
    months.each do |month|  
      a = body.scan(/\b#{month}\s\d{1,2}\b/i) 
      if(!a.nil? && e_date.nil?)
        e_date = Chronic.parse(a)
      end
    end
    puts "a4: " + a.to_s
    puts "chronic4: " + e_date.to_s
    
    months.each do |month|  
      a = body.scan(/\b#{month}\b/i)
      if(!a.nil? && e_date.nil?)
        e_date = Chronic.parse(a)
      end
    end
    puts "a5: " + a.to_s
    puts "chronic5: " + e_date.to_s
  
    if (!e_date.nil?)
      x = e_date.strftime("%m/%d/%Y")
      x << " "
    end 
    
    puts "x1: " + x.to_s
    
    #source: http://regexlib.com/REDetails.aspx?regexp_id=144
    b = body.scan(/((([0]?[1-9]|1[0-2])(:|\.)[0-5][0-9]((:|\.)[0-5][0-9])?( )?(AM|am|aM|Am|PM|pm|pM|Pm))|(([0]?[0-9]|1[0-9]|2[0-3])(:|\.)[0-5][0-9]((:|\.)[0-5][0-9])?))/)
    y = Chronic.parse(b)
    puts "y1: " + y.to_s
    if(y==nil || y.to_s == "")
        #x << y.strftime("%H:%M")
            b = body.scan(/([0]?[1-9]|1[0-2])?( )?(AM|am|aM|Am|PM|pm|pM|Pm)/)
            y = Chronic.parse(b) 
            puts "y2: " + y.to_s
            if(y!=nil)
              #x << " " 
             # x << y.strftime("%H:%M")
              puts "y2.1: " + y.strftime("%H:%M")
            end
    else
      if(y!=nil)
              x << " " 
              x << y.strftime("%H:%M")
              puts "y2.0: " + y.strftime("%H:%M")
      end
    
    end
    
   
    break;
    
  end
  e_date = Chronic.parse(x)
  puts "mcdonald: " + e_date.to_s
  puts "burger king: " + x.to_s
#  e_date.strftime("%m-%d-%Y") #date
#  e_date.strftime("%H:%M") #time
  return e_date
  
end

gmail = Gmail.connect("pewpew4720", "nomnom4720")

#puts gmail.inbox.count(:unread)  # print unread count

gmail.inbox.find(:unread).each do |mail|
  from = mail.message.from.to_s
  subject = mail.message.subject.to_s
  body = mail.message.body.to_s

#=begin  
  chronicDate = searchBody(body) 
  if(chronicDate != nil)
    e_date = chronicDate.strftime("%m-%d-%Y") #date
    e_time = chronicDate.strftime("%H:%M") #time  
#=end
 
  # Test outputs
  puts "from: " + from
  puts "subject: " + subject
  puts "date: " + e_date
  puts "time: " + e_time
  puts "body: " + body.gsub(%r{</?[^>]+?>}, '')
  puts "-------"  
end

#gmail.logout
end