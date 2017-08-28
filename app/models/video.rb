class Video < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged
  acts_as_taggable

  validate :youtube_url_kind
  validates :name, presence: true

  before_validation :autocomplete_name
  before_validation :set_thumbnail_url

  default_scope { order(position: :asc) }

  def tag_list
    tags.join(', ')
  end

  def youtube_id
    return nil unless youtube_url
    youtube_url.id
  end

  private

  def youtube_url_kind
    errors.add(:url, 'should link to a youtube video') unless youtube_url && youtube_url.kind == :video
  end

  def youtube_url
    return nil unless url.present?
    @youtube_url ||= Yt::URL.new(url)
  end

  def youtube_video
    return nil unless youtube_url
    @youtube_video = Yt::Video.new(id: youtube_id)
  end

  def autocomplete_name
    return if name.present?
    return unless name_changed?
    return unless youtube_video
    self.name = youtube_video.title
  end

  def set_thumbnail_url
    return unless url_changed?
    return unless youtube_video
    self.thumbnail_url = youtube_video.thumbnails['maxres']['url']
  end
end
