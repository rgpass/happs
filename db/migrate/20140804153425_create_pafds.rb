class CreatePafds < ActiveRecord::Migration
  def change
    create_table :pafds do |t|
      t.float :gratitude
      t.float :optimism
      t.float :comparison
      t.float :kindness
      t.float :relationships
      t.float :coping
      t.float :forgiveness
      t.float :engagement
      t.float :joys
      t.float :goals
      t.float :spirituality
      t.float :body

      t.timestamps
    end
  end
end
