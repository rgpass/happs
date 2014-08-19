class AddAttachmentPhotoToJoys < ActiveRecord::Migration
  def self.up
    change_table :joys do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :joys, :photo
  end
end
