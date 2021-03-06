class Product < ActiveRecord::Base
	has_many :carts, :through => :items
	has_many :items, :dependent => :destroy

	validates :name, :presence => true
	validates :description, :presence => true	
	validates :unit_price, :numericality => 
		{:greater_than => 0.01, :less_than_or_equal_to => 100.00}
	validates :quantity_on_hand, :numericality =>
		{:greater_than => 0, :less_than_or_equal_to => 5000}	


after_save :store_image
before_destroy :remove_image
  
IMAGE_DIRECTORY = File.join Rails.root, 'public', 'image_store'
def image=(file_data)
   unless file_data.blank? 
     @file_data = file_data     
self.extension =
          file_data.original_filename.split('.').last.downcase
   end
end
def image_filename
   File.join IMAGE_DIRECTORY, "#{id}.#{extension}"
end
  
def image_path
   "/image_store/#{id}.#{extension}"
end
  
def has_image?
   File.exists? image_filename
end
  
private
def store_image
   if @file_data
     FileUtils.mkdir_p IMAGE_DIRECTORY
     File.open(image_filename, 'wb') do |f|
       f.write(@file_data.read)
     end
@file_data = nil
   end
end
  
def remove_image
   FileUtils.rm image_filename, :force => true
end
end
