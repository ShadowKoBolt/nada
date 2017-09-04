class AddThumbnailToVideos < ActiveRecord::Migration[5.1]
  def up
    add_attachment :videos, :thumbnail
  end

  def down
    remove_attachment :videos, :thumbnail
  end
end
