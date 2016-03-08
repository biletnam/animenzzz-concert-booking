class AddAttachmentPosterVenueImageToRecitals < ActiveRecord::Migration
  def self.up
    change_table :recitals do |t|
      t.attachment :poster
      t.attachment :venue_image
    end
  end

  def self.down
    remove_attachment :recitals, :poster
    remove_attachment :recitals, :venue_image
  end
end
