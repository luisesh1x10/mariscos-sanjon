class SaucerOrder < ActiveRecord::Base
  belongs_to :orders
  belongs_to :patillos
   validates :orders_id,
  :patillos_id,
  presence:true
end
