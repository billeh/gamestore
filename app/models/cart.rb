class Cart < ActiveRecord::Base
	has_many :products, :through => :items
	has_many :items, :dependent => :destroy
	belongs_to :user
	validates :name, :presence => true
end
