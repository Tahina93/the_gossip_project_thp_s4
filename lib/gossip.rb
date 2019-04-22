require 'csv'
require 'pry'

class Gossip
   attr_reader :author, :content
  
  def initialize(author, content)
  	@content = content
 	@author = author
  end

  def save 
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  #affiche tout les gossip sur la page d'accueil 
  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    
    return all_gossips
  end

  #ouvrir le bon gossip dans le csv
  def self.find(id)
    CSV.read("./db/gossip.csv")[id]
  end

  def self.update(id, author, content)
  	csv_new = CSV.read("./db/gossip.csv")
  	csv_new.each_index do |index|
  	  if index == id.to_i
  	  	csv_new[index][0] = author
  	  	csv_new[index][1] = content
  	  end
  	end

  	CSV.open('./db/gossip.csv', 'wb') do |csv|
  	  csv_new.each do |row|
  	  	csv << row
  	  end
  	end
  end

end

#binding.pry 