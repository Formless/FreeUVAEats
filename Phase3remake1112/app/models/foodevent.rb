class Foodevent < ActiveRecord::Base
  
def self.search(search)
  if search
    find(:all, :conditions => ['body LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end
  
  
end
