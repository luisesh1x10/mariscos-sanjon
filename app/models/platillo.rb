class Platillo < ActiveRecord::Base
  
  belongs_to :category
  belongs_to :group
  has_many :saucerOrders
  has_many :orders, through: :saucerOrders
  
  validates_presence_of :category
  validates_presence_of :group
  validates :price,:name,
  presence:true
  has_many :ingredients
  has_many :platillo_ingredient, :through => :ingredients
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  
  validates :is_child,
    :inclusion => { :in => [true, false] }
  validates :is_child,
    :presence => { :if => 'is_child.nil?' }
end
