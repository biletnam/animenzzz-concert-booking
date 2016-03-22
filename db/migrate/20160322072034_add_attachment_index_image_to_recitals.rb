class AddAttachmentIndexImageToRecitals < ActiveRecord::Migration
  def self.up
    change_table :recitals do |t|
      t.attachment :index_image
    end
  end

  def self.down
    remove_attachment :recitals, :index_image
  end
end
