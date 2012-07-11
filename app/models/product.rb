class Product < ActiveRecord::Base
  default_scope :order => 'title'
  has_many :line_items
  has_many :orders, :through => :line_items
  
  before_destroy :enshure_not_referenced_by_any_line_item
  def enshure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
  
  attr_accessible :description, :image_url, :price, :title
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => {
    :with => %r{\.(gif|png|jpg|jpeg)$}i,
    :message => 'must be an URL for gif or png or jpg or jpeg image'
  }
  validates_length_of :title,:minimum => 10, :too_short => "Product's title is too short! It must be at least 10 characters!"
end
