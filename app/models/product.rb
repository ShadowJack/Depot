class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => {
    :with => %r{\.(gif|png|jpg|jpeg)$}i,
    :message => 'must be an URL for gif or png or jpg or jpeg image'
  }
  validates :title, :length => {:minimum => 10}
end
