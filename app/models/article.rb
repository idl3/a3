class Article < ActiveRecord::Base
  belongs_to :postable, :polymorphic => true
  has_many :comments
end
