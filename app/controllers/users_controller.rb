class UsersController < ApplicationController
  def new
   @title = "Sign up"
   @user = User.new
  end

  def show
    @user=User.find(params[:id])
    @title=@user.name
  end

  def create
    @user=User.new(params[:user])
    if @user.save
      sign_in @user  #to sign in the user upon signup
      flash[:success]="Welcome to the sample App!"
      redirect_to @user
    else
      #before render Users controller  new  action page ,we need clear the value of password
      @title="Sign up"
      @user.password=""
      @user.password_confirmation=""
      render 'new'
    end
  end
end
