module CouponHelper
  def format_coupon(coupon)
    if coupon.amount_off.present?
      "-#{Money.new(coupon.amount_off, coupon.currency).format} (promo code '#{coupon.id}')"
    elsif coupon.precent_off.present?
      "-#{coupon.precent_off}% (promo code '#{coupon.id}')"
    end
  end
end
