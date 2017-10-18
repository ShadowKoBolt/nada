class Discount < ApplicationRecord
  CURRENCY_CODE = 'gbp'.freeze

  validates :code, presence: true, uniqueness: true
  validates :discount, presence: true, numericality: { only_integer: true, min: 1 }

  class << self
    def active
      where('start_date <= :date AND end_date >= :date', date: Date.today)
    end
  end

  def discount_pounds
    discount.to_f/100.0
  end

  def discount_pounds=(val)
    self.discount = (val.to_f * 100.0).to_i
  end
end
