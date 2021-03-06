class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    joins(boats: [:classifications]).where("classifications.name = ?", "Catamaran")
  end
  
  def self.sailors
    joins(boats: [:classifications]).where("classifications.name = ?", "Sailboat").distinct
  end
  
  def self.talented_seafarers
    captains = []
    sailors.each {|sailor| captains << sailor.id}
    includes(boats: :classifications).where({classifications: {name: "Motorboat"}, captains: {id: captains}})
  end
  
  def self.non_sailors
    where.not("id IN (?)", sailors.pluck(:id))
    
  end
  
end
