class RegistrationsController < Devise::RegistrationsController
  layout 'application_base'

  def new
    @user = User.new
    @user = User::RegistrationForm.new(@user)
  end

  def create
    @user = User.new
    @user = User::RegistrationForm.new(@user)

    if @user.validate(new_user_params) && @user.save
      @user = @user.model
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render action: :new
    end
  end

  def edit
    @user = User::MyAccountForm.new(current_user)
  end

  def update
    @user = User::MyAccountForm.new(current_user)
    if @user.validate(edit_user_params) && @user.save
      redirect_to members_area_path, notice: 'Account updated'
    else
      render action: :edit
    end
  end

  private

  def new_user_params
    params.require(:user).permit(:email, :phone, :first_name, :last_name,
                                 :address_line_1, :address_line_2, :address_line_3,
                                 :city, :region, :postcode, :country, :password, :password_confirmation)
  end

  def edit_user_params
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    params.require(:user).permit(:email, :phone, :first_name, :last_name,
                                 :address_line_1, :address_line_2, :address_line_3,
                                 :city, :region, :postcode, :country, :password, :password_confirmation,
                                 :current_password)
  end
end
