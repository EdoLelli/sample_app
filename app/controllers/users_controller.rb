class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  def index
    @users=User.paginate(page: params[:page])
  end
  
  def show
    @user=User.find(params[:id])
    @microposts=@user.microposts.paginate(page: params[:page])
  end
  def new
    @user=User.new
    
  end
  def create
   @user=User.new(params[:user]) 
   if @user.save
      sign_in @user
      redirect_to @user
      flash[:success]="Welcome to Sample App!" 
    else render "users/new"
    end
  end
  def edit
    @user=User.find(params[:id])
    
  end
  def update
    
    if current_user.update(params[:user])
      redirect_to current_user
      flash[:success]="Account correctly modified"
    else 
      flash.now[:error]="Error"
      render "edit"
      
    end
  end
  def destroy
   @user=User.find(params[:id])
   if @user.destroy
     flash[:success]="User correctly deleted!"
     redirect_to users_path
   end
      end
   def followers
     @title="Followers"
     @user=User.find(params[:id])
     @users=@user.followers.paginate(page: params[:page])
     render 'following_followers'
   end
   def following
     @title="Following"
     @user=User.find(params[:id])
    @users=@user.followed_users.paginate(page: params[:page])
     render 'following_followers'
   end
  



def correct_user
  @user=User.find(params[:id])
  redirect_to root_path unless current_user?(@user)
end

private


def admin_user
      redirect_to(root_url) unless admin?
    end
  end
  

