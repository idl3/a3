class Article < ActiveRecord::Base
  belongs_to :postable, :polymorphic => true
  belongs_to :category
  has_many :comments
end
