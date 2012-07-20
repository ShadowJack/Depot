# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  has_many :assignments
  has_many :roles, :through => :assignments
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids
  # attr_accessible :title, :body
  def role? (role_sym)
    roles.any? {|r| r.name.underscore.to_sym == role_sym}
  end
end
