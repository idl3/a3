class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :banned, :name, :linkedin_id, :security_string
  has_one :person
  has_many :businesses
  has_many :contributions
  has_many :posts, :as => :postable
  serialize :roles
  serialize :meta, Hash

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

  def self.find_for_linkedin_oauth(user_profile, signed_in_resource=nil)
    userString = user_profile.site_standard_profile_request.url.sub 'http://www.linkedin.com/profile?viewProfile=&key=', ''
    i = 0
    until userString[i+1] == '&' do i += 1 end
    linkedin_id = userString[0..i]
    puts linkedin_id
    if signed_in_resource and signed_in_resource.try(:linkedin_id) != linkedin_id
      signed_in_resource.linkedin_id = linkedin_id
      signed_in_resource.save
      signed_in_resource
    else
      require 'securerandom'
      security_string = SecureRandom.hex(16)
      if user = self.find_by_linkedin_id(linkedin_id)
        puts "Found user"
        user.update_attribute(:security_string, security_string)
        user
      else
        puts "User not found"
        newuser = self.new(:password => Devise.friendly_token[0,20], :linkedin_id => linkedin_id, :security_string => security_string, email: "#{linkedin_id}@actatlys.com")
        newuser.save(:validate => false)
        newuser
      end
    end
  end
end
