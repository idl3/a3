class Comment < ActiveRecord::Base
  belongs_to :article, :dependent => :destroy
end
