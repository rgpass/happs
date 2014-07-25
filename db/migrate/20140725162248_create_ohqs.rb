class CreateOhqs < ActiveRecord::Migration
  def change
    create_table :ohqs do |t|
      t.float :score
      t.integer :user_id

      t.timestamps
    end
  end
end
