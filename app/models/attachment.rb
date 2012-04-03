require 'carrierwave/orm/activerecord'
class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  mount_uploader :content, AttachmentUploader
  attr_accessible :content, :attachable_id, :attachable_type, :category
  validates_presence_of :attachable_id, :attachable_type, :content

  def logo?
    self.category == "primarylogo"
  end
  def url
    self.logo? ? self.content_url : false
  end

  def name
    self.logo? ? self.content_identifier : false
  end
end
