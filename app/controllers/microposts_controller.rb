class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  def create

     @micropost=current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success]="Micropost correctly posted!"
      redirect_to root_path
  else 
    @feed_items= []
    render 'static_pages/home'
  end
  end
  def destroy
   
    @micropost=current_user.microposts.find(params[:id])
     if @micropost.destroy

     
       redirect_to root_path
    
   end
  end
  
  private
  
  def correct_user
     @micropost = Micropost.find_by(id: params[:id]) 
     redirect_to root_url unless current_user?(@micropost.user)
    end
  end
