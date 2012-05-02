class Media < ActiveRecord::Base
  belongs_to :business
  serialize :press, Array
  serialize :videos, Array
  serialize :phtoos, Array
end
