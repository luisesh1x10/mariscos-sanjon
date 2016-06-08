class SaucerOrder < ActiveRecord::Base
  belongs_to :platillo
  belongs_to :order
end
