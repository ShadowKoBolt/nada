class DanceClass < ApplicationRecord
  STYLE_OPTIONS = ['Egyptian Belly Dance', 'Fusion', 'Turkish Belly Dance', 'Tribal ATS', 'Gothic Belly Dance',
                   'Tribal Fusion', 'Folkloric', 'Gulf', 'Iraqi', 'Gypsy'].freeze
  LEVEL_OPTIONS = ['Open level', 'Beginner', 'Improver', 'Intermediate', 'Advanced'].freeze
  DISTANCE_OPTIONS = [['Within 50 miles', 50],
                      ['Within 25 miles', 25],
                      ['Within 10 miles', 10],
                      ['Within 5 miles', 5]].freeze

  include PgSearch
  pg_search_scope :search,
    associated_against: { user: [:first_name, :last_name] },
    using: { tsearch: { prefix: true, any_word: true }, trigram: { threshold: 0.1 } }

  belongs_to :user

  geocoded_by :full_street_address
  before_validation :geocode

  validates :name, :address_1, :postcode, :latitude, :longitude, presence: true

  def full_street_address
    [address_1, address_2, address_3, city, region, postcode, 'United Kingdom'].reject(&:blank?).join(', ')
  end

  def address_html
    [address_1, address_2, address_3, city, region, postcode, 'United Kingdom'].reject(&:blank?).join('<br />')
  end
end
