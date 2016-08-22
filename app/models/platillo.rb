class Platillo < ActiveRecord::Base
  has_attached_file :cover , styles:{mediano:"1280x720",tumb:"800x600"}
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
  has_attached_file :map, :styles => { :medium => "238x238>", 
                                   :thumb => "100x100>"
                                 }
  
  validates_attachment_content_type :map, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)'                              
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
