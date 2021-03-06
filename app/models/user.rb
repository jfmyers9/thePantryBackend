class User < ActiveRecord::Base

  has_many :shop_lists, :dependent => :destroy
  has_many :inventories, :dependent => :destroy
  has_many :recipes, :dependent => :destroy
  has_many :user_recipes, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  before_save :ensure_authentication_token

end
