class AddUserIdToPafd < ActiveRecord::Migration
  def change
  	add_column :pafds, :user_id, :integer
  end
end
