module Admin
  class DanceClassesController < Admin::BaseController
    before_action :find_user

    def index
      @dance_classes = @user.dance_classes
    end

    def new
      @dance_class = @user.dance_classes.build
    end

    def create
      @dance_class = @user.dance_classes.build(dance_class_params)
      if @dance_class.save
        redirect_to admin_user_dance_classes_path(@user), notice: 'Dance class created'
      else
        render action: :new
      end
    end

    def edit
      @dance_class = @user.dance_classes.find(params[:id])
    end

    def update
      @dance_class = @user.dance_classes.find(params[:id])
      if @dance_class.update(dance_class_params)
        redirect_to admin_user_dance_classes_path(@user), notice: 'Dance class updated'
      else
        render action: :edit
      end
    end


    def destroy
      dance_class = @user.dance_classes.find(params[:id])
      dance_class.destroy
      redirect_to admin_user_dance_classes_path(@user), notice: 'Dance class removed'
    end

    private

    def find_user
      @user = User.find(params[:user_id])
    end

    def dance_class_params
      params.require(:dance_class).permit(:name, :level, :style, :address_1, :address_2, :address_3,
                                          :city, :region, :postcode, :description)
    end
  end
end
