class User < ActiveRecord::Base
  belongs_to :practice
  has_many :medications, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  after_create do
    self.practice_id = 1
    self.save!
  end

  def self.find_for_github(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(email: data["email"], password: Devise.friendly_token[0,20])
    end
    user
  end
  
  def self.find_for_twitter(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(email: data["email"], password: Devise.friendly_token[0,20])
    end
    user
  end

end
