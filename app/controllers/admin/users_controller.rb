class Admin::UsersController < Admin::BaseController
  before_filter :authenticate_user!, only: [:index, :destroy]
  before_action :set_user  

  def index
    @users = User.paginate(page: params[:page])
    authorize @user    
  end

  private

    def set_user
      @user = current_user
    end

end  