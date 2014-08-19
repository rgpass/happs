class AddAttachmentPhotoToKindnesses < ActiveRecord::Migration
  def self.up
    change_table :kindnesses do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :kindnesses, :photo
  end
end
