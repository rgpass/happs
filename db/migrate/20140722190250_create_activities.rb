class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.string :url
      t.string :category

      t.timestamps
    end
  end
end
