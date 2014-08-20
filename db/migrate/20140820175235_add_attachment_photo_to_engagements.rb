class AddAttachmentPhotoToEngagements < ActiveRecord::Migration
  def self.up
    change_table :engagements do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :engagements, :photo
  end
end
