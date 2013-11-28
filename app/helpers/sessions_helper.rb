module SessionsHelper
  def sign_in(user)
    remember_token= User.new_remember_token
    cookies.permanent[:remember_token]=remember_token
     user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user=user
  end



def current_user=(user)
  @current_user=user
end

def current_user
  remember_token = User.encrypt(cookies[:remember_token])
  @current_user ||= User.find_by(remember_token: remember_token)
end


def signed_in?
  !current_user.nil?
end

def sign_out(user)
  self.current_user = nil
  cookies.delete(:remember_token)
end
def current_user?(user)
  user==current_user
end

def signed_in_user
  unless signed_in?
   storing 
  redirect_to signin_path, notice: "Before you have to Sign in!" 
  end
end

def storing
  session[:return_to] = request.url if request.get? 
end

def redirecting(default)
  redirect_to(session[:return_to] || default)
  session.delete(:return_to)
end
def admin?
  current_user.admin?
end
end

