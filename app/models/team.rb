class Team < ApplicationRecord
  validates :name, presence: true

  default_scope { order(position: :asc) }

  has_many :team_members
end
