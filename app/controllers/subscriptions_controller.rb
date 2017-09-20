class SubscriptionsController < BaseController
  def one_off

  end

  def new
    @plan = Stripe::Plan.retrieve(current_user.appropriate_plan_name)
    @subscription = Subscription.new
  end

  def show_confirm
    @plan = Stripe::Plan.retrieve(current_user.appropriate_plan_name)
    @subscription = Subscription.new(show_confirm_params)
    if @subscription.valid?
    else
      render action: :new
    end
  end

  def create
    @plan = Stripe::Plan.retrieve(current_user.appropriate_plan_name)
    @subscription = Subscription.new(create_params)
    if @subscription.valid?
      begin
        customer = Stripe::Customer.create(email: current_user.email, source: @subscription.stripe_token)
        subscription_attributes = { customer: customer.id, items: [plan: @plan.id] }
        subscription_attributes[:coupon] = @subscription.promo_code if @subscription.promo_code.present?
        Stripe::Subscription.create(subscription_attributes)
        current_user.update(stripe_customer_id: customer.id, renewal_date: 100.years.from_now, status: 'Confirmed')
        redirect_to members_area_path, notice: 'Subscription created'
      rescue Stripe::CardError => e
        @subscription.errors.add(:base, e)
        render action: :show_confirm
      end
    else
      render action: :new
    end
  end

  private

  def show_confirm_params
    params.require(:subscription).permit(:promo_code)
  end

  def create_params
    params.require(:subscription).permit(:promo_code, :stripe_token)
  end
end
