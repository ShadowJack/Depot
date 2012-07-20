class Assignement < ActiveRecord::Migration
  def up
    create_table :assignments do |t|
      t.integer :user_id
      t.integer :role_id
    end
  end

  def down
  end
end
