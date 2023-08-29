class FollowingsController < UsersController
  before_action :find_user, :logged_in_user, only: :index

  def index
    @title = t ".following"
    @pagy, @users = pagy @user.following
    render "show_follow", status: :unprocessable_entity
  end
end
