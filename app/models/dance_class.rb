class DanceClass < ApplicationRecord
  STYLE_OPTIONS = ['Egyptian Belly Dance', 'Fusion', 'Turkish Belly Dance', 'Tribal ATS', 'Gothic Belly Dance',
                   'Tribal Fusion', 'Folkloric', 'Gulf', 'Iraqi', 'Gypsy'].freeze
  LEVEL_OPTIONS = ['Open level', 'Beginner', 'Intermediate', 'Advanced'].freeze
  DISTANCE_OPTIONS = [['Within 5 miles', 5],
                      ['Within 10 miles', 10],
                      ['Within 25 miles', 25],
                      ['Within 50 miles', 50],
                      ['Within 100 miles', 100]].freeze

  belongs_to :user

  geocoded_by :full_street_address
  after_validation :geocode

  validates :name, :address_1, :postcode, presence: true

  def full_street_address
    [address_1, address_2, address_3, city, region, postcode, 'United Kingdom'].reject(&:blank?).join(', ')
  end
end
