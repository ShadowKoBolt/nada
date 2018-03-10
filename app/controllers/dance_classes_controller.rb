class DanceClassesController < BaseController
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
      ApplicationMailer.dance_class_added(@dance_class.id).deliver_now
      redirect_to dance_classes_path, notice: 'Dance class created'
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
      ApplicationMailer.dance_class_edited(@dance_class.id).deliver_now
      redirect_to dance_classes_path, notice: 'Dance class updated'
    else
      render action: :edit
    end
  end


  def destroy
    dance_class = @user.dance_classes.find(params[:id])
    dance_class.destroy
    redirect_to dance_classes_path, notice: 'Dance class removed'
  end

  private

  def find_user
    @user = current_user
  end

  def dance_class_params
    params.require(:dance_class).permit(:name, :level, :style, :address_1, :address_2, :address_3,
                                        :city, :region, :postcode, :description, :latitude, :longitude)
  end
end
