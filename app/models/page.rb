class Page < ActiveRecord::Base
  belongs_to :postable, :polymorphic => true
end
