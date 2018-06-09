class Platillo < ActiveRecord::Base
  has_attached_file :cover, styles: {big: "1024x780>", medium: "600x600>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
  
  belongs_to :category
  belongs_to :group
  has_many :saucer_orders
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
