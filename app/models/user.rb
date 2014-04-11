class User < ActiveRecord::Base
has_one :cart
has_secure_password
validates :email, :password, :presence => true
validates :email, :uniqueness => true
attr_accessible :email, :password, :password_confirmation
end
