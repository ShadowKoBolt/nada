module Admin
  class DiscountsController < Admin::BaseController
    skip_before_action :verify_authenticity_token, only: [:reorder]

    def index
      @discounts = Discount.all
    end

    def new
      @discount = Discount.new
    end

    def create
      @discount = Discount.new(discount_params)
      if @discount.save
        redirect_to admin_discounts_path, notice: 'Discount added'
      else
        render action: :new
      end
    end

    def edit
      @discount = Discount.find(params[:id])
    end

    def update
      @discount = Discount.find(params[:id])
      if @discount.update(discount_params)
        redirect_to admin_discounts_path, notice: 'Discount updated'
      else
        render action: :edit
      end
    end

    def destroy
      @discount = Discount.find(params[:id])
      @discount.destroy
      redirect_to admin_discounts_path, notice: 'Discount removed'
    end

    def reorder
      params[:discount].each.with_index do |id, index|
        Discount.find(id).update(position: index + 1)
      end
      render status: :ok, body: nil
    end

    private

    def discount_params
      params.require(:discount).permit(:code, :discount_pounds, :start_date, :end_date)
    end
  end
end
