module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id,user.salt]
    current_user =user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    #@current_user
    @current_user ||= user_from_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
     cookies.delete(:remember_token)
     current_user=nil
  end

  private
     def user_from_remember_token
       #* operator, which allows us to use a two-element array as an argument to a method expecting two variables
       #cookies.signed[:remember_me] returns an array of two elements—the user id and the sal
       User.authenticate_with_salt(*remember_token)
     end

     def remember_token
       cookies.signed[:remember_token] || [nil,nil]
     end

end
