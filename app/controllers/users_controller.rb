class UsersController < ApplicationController
  def index
    @user=User.all
  end
  
  def show
    @user=User.find(params[:id])
    
  end
  def new
    @user=User.new
  end
  def create
   @user=User.new(params[:user]) 
   if @user.save
      sign_in @user
      redirect_to @user
      flash[:success]="Welcome to my Sample App!" 
    else render "users/new"
    end
  end
  def edit
    
  end
  def update
    
  end
  def delete
    
  end
  
end



