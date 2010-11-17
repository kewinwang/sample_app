class UsersController < ApplicationController
  before_filter :authenticate ,:only =>[:index,:edit ,:update]
  before_filter :correct_user ,:only =>[:edit ,:update]
  before_filter :admin_user   ,:only => :destroy


  def new
   @title = "Sign up"
   @user = User.new
  end

  def index
    @title="All users"
    @users=User.paginate(:page=>params[:page])
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

  def edit
     #here we can omit the @user initial ,as we use correct_user before_filter defined @user
     #@user=User.find(params[:id])
     @title="Edit user"
  end


  def update
    #@user=User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success]="Profile updated"
      redirect_to @user
    else
      @title="Edit user"
      render 'edit'
    end
  end


  def destroy
    User.find(params[:id]).destroy
    flash[:success]="User destroyed"
    redirect_to users_path
  end


  private

     def authenticate
       deny_access unless signed_in?
     end

     def correct_user
       #to define the correct user and omit it at edit and update
       @user=User.find(params[:id])
       redirect_to(root_path) unless current_user?(@user)
     end

     def admin_user
       redirect_to(root_path) unless current_user.admin?
     end


     #def admin?


end
