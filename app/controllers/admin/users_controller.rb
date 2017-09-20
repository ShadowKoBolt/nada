require 'csv'

class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
    @users = @users.search(params[:term]) if params[:term].present?
  end

  def download
    @users = User.all
    send_data @users.to_csv, filename: "users-#{Date.today}.csv"
  end

  def new
    @user = User.new
    @user = User::AdminForm.new(@user)
  end

  def create
    @user = User.new
    @user = User::AdminForm.new(@user)
    if @user.validate(user_params)
      @user.save
      redirect_to admin_users_path, notice: 'User created'
    else
      render action: :new
    end
  end

  def edit
    @user = User.find(params[:id])
    @user = User::AdminForm.new(@user)
  end

  def update
    @user = User.find(params[:id])
    @user = User::AdminForm.new(@user)
    if @user.validate(user_params)
      @user.save
      redirect_to admin_users_path, notice: 'User updated'
    else
      render action: :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone, :first_name, :last_name,
                                 :address_line_1, :address_line_2, :address_line_3,
                                 :city, :region, :postcode, :country, :notes,
                                 :teacher, :teacher_email, :teacher_phone, :teaching_locations,
                                 :join_date, :renewal_date, :status, :admin)
  end
end
