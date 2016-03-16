class AddAttachmentScreenshotToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :screenshot
    end
  end

  def self.down
    remove_attachment :videos, :screenshot
  end
end
