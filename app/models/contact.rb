class Contact < ActiveRecord::Base
  belongs_to :contactable, :polymorphic => true
  attr_accessible :contactable_id, :contactable_type
end
