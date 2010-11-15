require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    it "should have the right title" do
      get 'new'
      response.should have_selector("title",:content => "Sign up")
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :show ,:id => @user
      response.should be_success
    end

    it "should find the right user" do
      # "get :show ,:id =@user "is the same as "get 'show',id = @user.id"
      get :show ,:id => @user

      #verifies that the variable retrieved from the database
      #in the action corresponds to the @user instance created by Factory Girl
      #assigns mathod:takes in a symbol argument and returns
      #the value of the corresponding instance variable in the controller action

      assigns(:user).should == @user
    end

    it "should  have the right title" do
       get :show ,:id => @user
       response.should have_selector("title",:content=>@user.name)
    end

    it "should include the user's name" do
      get :show ,:id =>@user
      response.should have_selector("h1",:content=>@user.name)
    end

    it "should have a profile image" do
      get :show ,:id =>@user
      response.should have_selector("h1>img",:class=>"gravatar")
    end

  end

  describe "POST 'create '" do
    #a test for creating user failure
    describe "failure" do
      before(:each) do
        @attr = {:name =>"",:email=>"",:password=>"",
               :password_confirmation=>""}
      end
      it "should not create a user" do
	lambda do
	  post:create,:user=>@attr
	end.should_not change(User,:count)
      end

      it "should have the right title" do
	post:create ,:user =>@attr
	response.should have_selector("title",:content => "Sign up")
      end

      it "should render the 'new' page " do
	post :create,:user => @attr
	response.should render_template('new')
      end

    end

    # a test for creating user successful
    describe "success" do
      before(:each) do
        @attr= {:name =>"New User",:email=>"user@examlpe.com",
	        :password=>"foobar",:password_confirmation=>"foobar"
	        }
      end

      it "should create a uer" do
	lambda do
	  post :create,:user =>@attr
	end.should change(User,:count).by(1)
      end

      it "should redirect to the user show page" do
	post :create ,:user=>@attr
	response.should redirect_to(user_path(assigns(:user)))
      end

       # a test for flash message
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end

    end
  end
end
