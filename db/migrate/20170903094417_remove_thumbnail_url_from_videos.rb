class RemoveThumbnailUrlFromVideos < ActiveRecord::Migration[5.1]
  def change
    remove_column :videos, :thumbnail_url, :string
  end
end
