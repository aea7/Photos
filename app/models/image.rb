class Image < ActiveRecord::Base
  acts_as_votable 
  belongs_to :user
  belongs_to :category
  mount_uploader :picture, PictureUploader
end
