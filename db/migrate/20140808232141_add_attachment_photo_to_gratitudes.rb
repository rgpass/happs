class AddAttachmentPhotoToGratitudes < ActiveRecord::Migration
  def self.up
    change_table :gratitudes do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :gratitudes, :photo
  end
end
