# frozen_string_literal: true

class SubscriptionsController < BaseController
  def one_off; end

  def new
    find_plans
    @subscription = Subscription.new(plan_id: @plans.first.id)
  end

  def show_confirm
    @subscription = Subscription.new(show_confirm_params)
    @plan = Stripe::Plan.retrieve(@subscription.plan_id)
    if @subscription.valid?
    else
      find_plans
      render action: :new
    end
  end

  def create
    @subscription = Subscription.new(create_params)
    @plan = Stripe::Plan.retrieve(@subscription.plan_id)
    if @subscription.valid?
      begin
        customer = Stripe::Customer.create(email: current_user.email, source: @subscription.stripe_token)
        subscription_attributes = { customer: customer.id, items: [plan: @plan.id] }
        subscription_attributes[:coupon] = @subscription.promo_code if @subscription.promo_code.present?
        Stripe::Subscription.create(subscription_attributes)
        current_user.update(
          stripe_customer_id: customer.id,
          renewal_date: 100.years.from_now,
          status: 'Confirmed',
          paperless: @plan.id == ENV['STRIPE_PLAN_NAME_PAPERLESS']
        )
        redirect_to members_area_path, notice: 'Subscription created'
      rescue Stripe::CardError => e
        @subscription.errors.add(:base, e)
        render action: :show_confirm
      end
    else
      find_plans
      render action: :new
    end
  end

  def find_promo
    @discount = Discount.active.where(code: params[:code]).first
    if @discount
      flash.now[:notice] = 'Discount added'
    else
      flash.now[:alert] = 'Unable to find valid code'
    end
    render action: :one_off
  end

  private

  def show_confirm_params
    params.require(:subscription).permit(:promo_code, :plan_id)
  end

  def create_params
    params.require(:subscription).permit(:promo_code, :plan_id, :stripe_token)
  end

  def find_plans
    @plans = [
      Stripe::Plan.retrieve(current_user.appropriate_plan_name),
      Stripe::Plan.retrieve(ENV['STRIPE_PLAN_NAME_PAPERLESS'])
    ]
  end
end
