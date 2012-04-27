class Business < ActiveRecord::Base
  belongs_to :user
  has_one :contact, :as => :contactable, :dependent => :destroy
  has_many :attachments, :as => :attachable, :dependent => :destroy
  attr_protected :id
  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :contact
  class << self; attr_accessor :type end
  attr_accessor :addnew
  @type = "Business"
  serialize :founders, Array
  serialize :advisors, Array
  serialize :competitors, Array
  serialize :target, Array
  serialize :investors, Array
  serialize :keystaff, Array

  def logo
    self.attachments.each do |a|
      puts a.inspect
      if a.logo?
        return a.url
      end
    end
    false
  end

end
