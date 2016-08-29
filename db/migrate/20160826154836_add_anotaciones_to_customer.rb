class AddAnotacionesToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :anotaciones, :text
    
  end
end
