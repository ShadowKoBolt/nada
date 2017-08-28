require 'open-uri'

class Magazine < ApplicationRecord
  has_attached_file :file, styles: { thumbnail: ["595x842", :png] }

  validates_attachment_content_type :file, content_type: 'application/pdf', presence: true
  validates :name, presence: true

  default_scope { order(position: :asc) }
end
