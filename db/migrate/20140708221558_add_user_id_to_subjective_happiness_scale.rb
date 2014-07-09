class AddUserIdToSubjectiveHappinessScale < ActiveRecord::Migration
  def change
    add_column :subjective_happiness_scales, :user_id, :integer
  end
end
