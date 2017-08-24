class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :get_profile

  def edit
    add_crumb 'Edit', 'edit_profile_path'
  end

  def show
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = "Update profile #{@profile.email} successfully"
      redirect_to profile_path
    else
      flash.now[:error] ||= []
      flash[:error] << "Update profile #{@profile.email} failured"
      flash[:error] << @profile.errors.full_messages.join(', ')
      render :edit
    end
  end

  protected
  def set_crumb
    super
    add_crumb 'Profile', 'profile_path'
  end

  private
  def get_profile
    @profile = current_user
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :birthday, :gender)
  end
end
