class CreateSubjectiveHappinessScales < ActiveRecord::Migration
  def change
    create_table :subjective_happiness_scales do |t|
      t.integer :general
      t.integer :peers
      t.integer :regardless
      t.integer :neg
      t.decimal :score

      t.timestamps
    end
  end
end
