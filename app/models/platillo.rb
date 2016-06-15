class Platillo < ActiveRecord::Base
  belongs_to :category
  has_many :ingredients
  has_many :platillo_ingredient, :through => :ingredients
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  has_attached_file :map, :styles => { :medium => "238x238>", 
                                   :thumb => "100x100>"
                                 }

                                 
  validates_attachment_content_type :map, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)'                               
end
