# -*- encoding : utf-8 -*-
class AddQuantityToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :quantity, :integer, :default => 1
  end
end
