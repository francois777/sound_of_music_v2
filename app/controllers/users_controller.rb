class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    unless (@user == current_user) || (current_user.role != 'user') || current_user.admin?
      redirect_to :back, :alert => t(:access_denied, scope: [:failure])
    end
  end

end
