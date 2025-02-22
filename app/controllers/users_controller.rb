class UsersController < ApplicationController

 before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user=User.find(params[:id])
    @book=Book.new
    @books=@user.books#テーブル
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
       flash[:notice]="You have updated user successfully."
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end

  def index
    @users=User.all
  end

  private
   def user_params
     params.require(:user).permit(:name,:profile_image,:introduction)
   end

   def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
   end

end
