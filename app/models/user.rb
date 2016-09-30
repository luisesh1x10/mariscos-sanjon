class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :tipo, inclusion: [1,2,3]
  #'Cocina'--->1
  #'mesero'--->2
  #'Caja'----->3
  has_many :saucer_orders
end
