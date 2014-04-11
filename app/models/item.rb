class Item < ActiveRecord::Base
	belongs_to :cart
	belongs_to :product
	def extended_price
    	self.quantity_ordered * self.product.unit_price
	end
end
