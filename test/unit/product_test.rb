# -*- encoding : utf-8 -*-
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  fixtures :products
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be more than 0" do
    product = Product.new :title => 'My title123',
                          :description => 'My description!',
                          :image_url => 'img.jpg'
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
        product.errors[:price].join('; ')
    
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
        product.errors[:price].join('; ')
        
    product.price = 1
    assert product.valid?
  end
  
  test "title length must be at least 10 characters" do
    product = Product.new :description => 'description is describing...',
                          :image_url => 'image.gif',
                          :price => 10
    product.title = 'Ololo'
    assert product.invalid?
    assert_equal "Product's title is too short! It must be at least 10 characters!",
                 product.errors[:title].join('; ')
                 
    product.title = 'OloloOlolo1'
    assert product.valid?
  end
  
  def new_product(image_url)
    product = Product.new( :title => 'My title123123123',
                          :description => 'My description!',
                          :image_url => image_url,
                          :price => 1)
  end
  
  test "image url" do
    
    ok = %w{a.jpg a.gif a.png a.JPG a.Png http:localhost.ru/a/b/c/d.gif}
    bad = %w{a.xls a.gif/one http:localhost.ru/a/b/c/d.gif/go}
    
    ok.each do |name|
      assert new_product(name).valid?, "#name shouldn't be invalid"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#name shouldn't be valid"
    end
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(:title       => products(:ruby).title,
                          :description => "yyy", 
                          :price       => 1, 
                          :image_url   => "fred.gif")

    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'),
                 product.errors[:title].join('; ')
  end
end
