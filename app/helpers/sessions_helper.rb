module SessionsHelper

  # signin method   to set the signed in user to cookies and set the current user
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id,user.salt]
    current_user =user
  end

  #to set the current user
  def current_user=(user)
    @current_user = user
  end

  #return currecnt user ,maybe from remebered token
  def current_user
    #@current_user ,maybe from remembered tokens
    @current_user ||= user_from_remember_token
  end

  # to check whether the currennt user is the right user
  def current_user?(user)
     user==current_user
  end

  # to check the user is whether signed in
  def signed_in?
    !current_user.nil?
  end

  #sign out method ,to delete user information stored in the cookies and clear the current_user
  def sign_out
     cookies.delete(:remember_token)
     current_user=nil
  end
  # deny access and redirect to "/signin " ,and give a notice
  def deny_access
    store_location
    redirect_to signin_path ,:notice=>"please sign in to access this page."
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to]||default)
    clear_rerurn_to
  end

  private
    def user_from_remember_token
       #* operator, which allows us to use a two-element array as an argument to a method expecting two variables
       #cookies.signed[:remember_me] returns an array of two elements—the user id and the sal
       User.authenticate_with_salt(*remember_token)
    end

    #this method will return a array with two elements
    def remember_token
       cookies.signed[:remember_token] || [nil,nil]
    end

    def store_location
      session[:return_to]=request.fullpath
    end

    def clear_rerurn_to
      session[:return_to]=nil
    end

end
