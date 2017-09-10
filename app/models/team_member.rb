class TeamMember < ApplicationRecord
  validates :name, :role, presence: true
  validates :image, attachment_presence: true
  has_attached_file :image, styles: { thumb: ["250x250#"] }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  default_scope { order(position: :asc) }

  belongs_to :team, optional: true

  def team_name
    return nil unless team
    team.name
  end
end
