class Contact < ActiveRecord::Base
  belongs_to :contactable, :polymorphic => true
  attr_accessible :contactable_id, :contactable_type, :phone, :website, :blog, :twitter, :facebook
end
