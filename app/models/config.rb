class Config < ActiveRecord::Base
    def self.iva
        Config.last.iva
    end
end
