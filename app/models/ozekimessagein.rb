class Ozekimessagein < ActiveRecord::Base
  
  def self.search(name1, number1, amount1)
    sc1 = "%" + name1 + "%"
    sc2 = "%" + number1 + "%"
    sc3 = "%" + amount1 + "%"
    @sms = Ozekimessagein.find(:all, :conditions => ['sender LIKE ? AND msg LIKE ? AND msg LIKE ? AND msg LIKE ?', "D48617A140", sc1,sc2,sc3])
  end
  
end
