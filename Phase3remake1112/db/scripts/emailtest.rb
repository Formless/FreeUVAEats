require 'rubygems'
require 'gmail'
require 'chronic'
require 'strscan'


e_from = nil
e_subject = nil
e_date = nil
e_time = nil
e_body = nil

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
  days = ['morning', 'night', 'tonight', 'Sunday', 'Sun', 'Monday', 'Mon', 'Tuesday', 'Tues', 'Wednesday', 'Wed', 'Thursday', 'Thurs', 'Friday', 'Fri', 'Saturday', 'Sat', 'Tomorrow', 'tomorrow', 'today', 'Today']
  months = ['January', 'Jan', 'February', 'Feb', 'March', 'Mar', 'April', 'Apr', 'May', 'June', 'July', 'August', 'September', 'Aug', 'Sept', 'October', 'Oct', 'November', 'Nov', 'December', 'Dec']
  
  x = 0
  while(x==0)
    
    a = body.scan(/\d{1,2}\/\d{1,2}\/\d{2,4}/)
    if(!a.nil? && e_date.nil?)
      e_date = Chronic.parse(a)
    end
    
 #   puts "chronic1: " + e_date.to_s
    
    a = body.scan(/\d{1,2}\-\d{1,2}\-\d{2,4}/)
    if(!a.nil? && e_date.nil?)
      e_date = Chronic.parse(a)
    end
    
 #   puts "chronic2: " + e_date.to_s
    
    adjectives.each do |adj|
     days.each do |day|
       a = body.scan(/\b(?:#{adj})\s(?:#{day})\b/i)
       if(!a.nil? && e_date.nil?)
        e_date = Chronic.parse(a)
       end
     end   
    end
    
 #   puts "chronic3: " + e_date.to_s
   
    months.each do |month|  
      a = body.scan(/\b#{month}\s\d{1,2}\b/i) 
      if(!a.nil? && e_date.nil?)
        e_date = Chronic.parse(a)
      end
    end
    
 #   puts "chronic4: " + e_date.to_s
    
    months.each do |month|  
      a = body.scan(/\b#{month}\b/i)
      if(!a.nil? && e_date.nil?)
        e_date = Chronic.parse(a)
      end
    end
    
  #  puts "chronic5: " + e_date.to_s
    
    days.each do |day|  
      a = body.scan(/\b#{day}\b/i)
 #     a.each {|x| print x, "--"}
      if(!a.nil? && e_date.nil?)
 #       puts "Spork!"
        e_date = Chronic.parse(a)
      end
    end
    
    
  #  puts "chronic5: " + e_date.to_s
  
    if (!e_date.nil?)
      x = e_date.strftime("%m/%d/%Y")
      info.push x
      x << " "
    end 
    
 #  puts "x1: " + x.to_s
    
    #source: http://regexlib.com/REDetails.aspx?regexp_id=144
    b = body.scan(/((([0]?[1-9]|1[0-2])(:|\.)[0-5][0-9]((:|\.)[0-5][0-9])?( )?(AM|am|aM|Am|PM|pm|pM|Pm))|(([0]?[0-9]|1[0-9]|2[0-3])(:|\.)[0-5][0-9]((:|\.)[0-5][0-9])?))/)
    y = Chronic.parse(b)
  #  puts "y1: " + y.to_s
    if(y==nil || y.to_s == "")
        #x << y.strftime("%H:%M")
            b = body.scan(/([0]?[1-9]|1[0-2])?( )?(AM|am|aM|Am|PM|pm|pM|Pm)/)
            y = Chronic.parse(b) 
   #         puts "y2a: " + y.to_s
            if(y!=nil)
              #x << " " 
              #x << y.strftime("%H:%M")
              info.push y.strftime("%H:%M")
            end
    else
      if(y!=nil)
              #x << " " 
              #x << y.strftime("%H:%M")
   #           puts "y2b: " + y.to_s
              info.push y.strftime("%H:%M")
      end
    
    end
    
   
    break;
    
  end

#  e_date = Chronic.parse(x)
#  puts "mcdonald: " + e_date.to_s
#  puts "burger king: " + x.to_s
#  e_date.strftime("%m-%d-%Y") #date
#  e_date.strftime("%H:%M") #time
  return info
  
end

#########################################
# MAIN


gmail = Gmail.connect("pewpew4720", "nomnom4720")

#puts gmail.inbox.count(:unread)  # print unread count

gmail.inbox.find(:unread).each do |mail|
  e_from = mail.message.from.to_s
  e_subject = mail.message.subject.to_s
  e_body = mail.message.body.to_s.gsub(%r{</?[^>]+?>}, '')

#=begin  
  chronicDate = searchBody(e_body) 
  if(chronicDate != nil)

 
  cdate = Chronic.parse(chronicDate[0])
  if (cdate != nil && cdate != "")
    e_date = cdate.strftime("%Y-%m-%d") #date
  else
    e_date = "unavailable" 
  end
  
 # puts "chronicDate[1]: " + chronicDate[1].to_s
  
  ctime = Chronic.parse(chronicDate[1])
  if (ctime != nil && ctime != "")
    e_time = ctime.strftime("%H:%M") #date
  else
    e_time = "unavailable" 
  end
  
 # e_time = Chronic.parse(chronicDate[1]).strftime("%H:%M") #time  
#=end
  #########################
  
  File.new("tmp/foo.log", "w+")
  myfile = File.open("tmp/foo.log", "w+")
  myfile.puts(e_from)
  myfile.puts(e_subject)
  myfile.puts(e_date)
  myfile.puts(e_time)
  myfile.puts(e_body)
  myfile.close
  #########################
  
  
  `rails runner db/scripts/vbtest.rb`
 

  # Test outputs
  puts "from: " + e_from
  puts "subject: " + e_subject
  puts "date: " + e_date
  puts "time: " + e_time
  puts "body: " + e_body
  puts "-------"  

=begin 
evs = Foodevent.new(
  :from => e_from,
  :subject => e_subject,
  :date => e_date,
  :time => e_time,
  :body => e_body
)
evs.save
=end

end

#gmail.logout
end