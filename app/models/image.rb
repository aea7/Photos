class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  mount_uploader :picture, PictureUploader
end
