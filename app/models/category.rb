class Category < ActiveRecord::Base
	validates_presence_of :name, :message => "El nombre no puede estar en blanco" 
	has_many  :platillos
	has_many :categorySucursals
	has_many :sucursals, through: :categorySucursals
	accepts_nested_attributes_for :sucursals, allow_destroy: true
end
