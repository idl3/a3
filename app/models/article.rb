class Article < ActiveRecord::Base
  belongs_to :postable, :polymorphic => true
  belongs_to :category
  has_many :comments
  has_many :attachments, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :attachments

  def leadimage?
    true
  end

  def leadimage
    unless self.attachments.blank?

    else
      "default-act.png"
    end
  end
end
