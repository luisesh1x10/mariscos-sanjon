class Bag < ActiveRecord::Base
    has_many :saucer_orders
    validates :status, :inclusion => {:in => [nil,1,2,3,4]}
    before_save :default_values
      def default_values
        self.status ||= 1
      end
end
