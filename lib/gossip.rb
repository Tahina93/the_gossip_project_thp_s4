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

  def self.update(i, modified_author, modified_content) 
		rows_array = CSV.read('../db/gossip.csv')
		desired_indices = [i].sort # these are rows you would like to modify
		rows_array.each.with_index(desired_indices[0]) do |row, index| 
	 if desired_indices.include?(index)
	  # modify over here
	  rows_array[index][0] = modified_author
	  rows_array[index][1] = modified_content
	 end
	end
		# now update the file
		CSV.open("../db/gossip.csv", 'wb') { |csv| rows_array.each{|row| csv << row}}

	end

end

#binding.pry 