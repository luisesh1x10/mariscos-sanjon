class MeasurementUnit < ActiveRecord::Base
	has_many :ingredientes
	validates_uniqueness_of :name, :message => "Este valor ya está registrado"
	validates_presence_of :name, :message => "El nombre no puede estar en blanco"   
end
