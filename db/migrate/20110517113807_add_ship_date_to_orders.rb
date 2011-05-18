class AddShipDateToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :ship_date, :string
  end

  def self.down
    remove_column :orders, :ship_date
  end
end
