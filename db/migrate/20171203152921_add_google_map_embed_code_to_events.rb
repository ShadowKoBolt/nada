class AddGoogleMapEmbedCodeToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :google_map_embed_code, :text
  end
end
