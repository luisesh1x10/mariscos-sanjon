class Table < ActiveRecord::Base
    has_many :orders
    validates :name , presence:true, uniqueness:true
    before_save :default_values
  def default_values
    self.take_away ||= false 
  end

end
