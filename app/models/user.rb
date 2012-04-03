class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_one :person
  has_many :businesses
  has_many :posts, :as => :postable
  serialize :roles

  def role?(role)
    self.roles.include?(role)
  end

  def admin?
    unless self.roles.nil?
      self.roles.include?(:admin)
    else
      false
    end
  end
end
