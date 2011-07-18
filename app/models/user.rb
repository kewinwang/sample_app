class User < ActiveRecord::Base

  attr_accessor :password
  attr_accessible :name, :email ,:password ,:password_confirmation

  before_save :encrypt_password

  has_many :microposts , :dependent => :destroy

  has_many :relationships, :foreign_key=>"follower_id" ,
                           :dependent=>:destroy

  has_many :following ,:through => :relationships,
                                   :source=>:followed

  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships,
                                   :source => :follower

  scope :admin, where(:admin => true)

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
                   :length   => { :maximum => 50}
  validates :email,:presence => true,
                   :format   => {:with => email_regex},
	            	   :uniqueness =>{:case_sensitive => false}
  validates :password, :presence     => true,
	                     :confirmation => true,
                       :length       => { :within => 6..40 }
  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
=begin
  def self.authenticate(email,submitted_password)
    user=find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
   end
=end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  # another implement of class method  authenticate_with_salt
=begin
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    return nil  if user.nil?
    return user if user.salt == cookie_salt
  end
=end

  def feed
    # This is preliminary. See Chapter 12 for the full implementation.
    # to avoid SQl injection
    Micropost.from_users_followed_by(self)
    # this is equivalent to
    # @microposts
  end

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end


  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password=encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    #The below is all kinks of implementation of authenticate
   #(1)The authenticate method with User in place of self
=begin
  def User.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end


  #(2)The authenticate method with an explicit third return
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
    return nil
  end

  #(3)The authenticate method using an if statement.
   def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    if user.nil?
      nil
    elsif user.has_password?(submitted_password)
      user
    else
      nil
    end
  end

  #(4)The authenticate method using an if statement and an implicit return.
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    if user.nil?
      nil
    elsif user.has_password?(submitted_password)
      user
    end
  end
=end
  #(5)The authenticate method using the ternary operator.
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
  end



end
