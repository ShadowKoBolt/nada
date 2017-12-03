class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :image, styles: { featured: '750x', thumb: 'x100' }
  validates_attachment :image,
    content_type: { content_type: /\Aimage\/.*\z/ },
    presence: true

  validates :name, presence: true

  default_scope { order(position: :asc) }

  def published_human
    published? ? 'Published' : 'Unpublished'
  end

  def first_paragraph
    Nokogiri::HTML.parse(body).css('p').first.text
  end

  def google_map_embed_code_iframe
    google_map_embed_code.gsub /width="\d\d\d"/, 'width="100%"'
  end
end
