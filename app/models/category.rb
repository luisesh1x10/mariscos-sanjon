class Category < ActiveRecord::Base
	validates_presence_of :name, :message => "El nombre no puede estar en blanco" 
end
