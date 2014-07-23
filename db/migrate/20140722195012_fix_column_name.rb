class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :activities, :url, :path
  end
end
