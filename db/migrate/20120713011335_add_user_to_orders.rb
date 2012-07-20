# -*- encoding : utf-8 -*-
class AddUserToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :user_id, :integer
  end
end
