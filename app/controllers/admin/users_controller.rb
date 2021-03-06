require 'csv'

class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(:first_name, :last_name, :email)
    filter_users
  end

  def download
    @users = User.all
    @users = @users.where(teacher: true) if params[:teachers]
    filter_users
    send_data @users.to_csv, filename: "users-#{Date.today}.csv"
  end

  def labels
    @users = User.all
    filter_users
    LabelGenerator.call(@users)
    send_file 'labels.pdf'
  end

  def new
    @user = User.new
    @user = User::AdminForm.new(@user)
  end

  def create
    @user = User.new
    @user = User::AdminForm.new(@user)
    if @user.validate(user_params) && @user.save
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
      redirect_to edit_admin_user_path(@user), notice: 'User updated'
    else
      render action: :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'User removed'
  end

  def renew_success
    @user = User.find(params[:id])
    ApplicationMailer.renew_success(@user.id).deliver
    redirect_to edit_admin_user_path(@user), notice: 'Email send'
  end

  private

  def user_params
    params[:user] ||= {}
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    params.require(:user).permit(:email, :phone, :first_name, :last_name,
                                 :address_line_1, :address_line_2,
                                 :address_line_3, :city, :region, :postcode,
                                 :country, :notes, :teacher, :teacher_email,
                                 :teacher_phone, :teaching_locations,
                                 :join_date, :renewal_date, :status, :admin,
                                 :password, :password_confirmation, :paperless)
  end

  def filter_users
    @users = @users.search(params[:term]) if params[:term].present?
    @users = @users.where('renewal_date < ?', Date.today) if params[:status] == 'lapsed'
    @users = @users.where('renewal_date >= ?', Date.today) if params[:status] == 'active'
    @users = @users.where('paperless IS true') if params[:paperless] == 'paperless'
    @users = @users.where('paperless IS false') if params[:paperless] == 'paper'
    @users = @users.where(email: params[:emails]) if params[:emails].present?
  end
end
