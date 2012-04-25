class Article < ActiveRecord::Base
  belongs_to :postable, :polymorphic => true
  belongs_to :category
  has_many :comments
  has_many :images, :as => :attachable, :dependent => :destroy

  def leadimage?
    true
  end

  def leadimage
    "default-act.png"
  end
end
