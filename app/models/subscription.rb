class Subscription
  include ActiveModel::Model

  attr_accessor :promo_code
  attr_accessor :coupon
  attr_accessor :stripe_token
  attr_accessor :plan_id

  validate do
    if promo_code.present?
      begin
        self.coupon = Stripe::Coupon.retrieve(promo_code)
        errors.add(:promo_code, "has expired") if Time.at(coupon.redeem_by) < Time.now
      rescue Stripe::InvalidRequestError
        errors.add(:promo_code, "can't be found - please check that you have entered it correctly")
      end
    end
  end
end
