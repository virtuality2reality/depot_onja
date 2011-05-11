class Product < ActiveRecord::Base
  validates :title, :description, :image_url, :presence => true
  validates :title, :uniqueness => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :image_url, :format => {
                                      :with => %r{\.(jpeg|jpg|gif|png)$}i,
                                      :message => 'Verify your image type'
                                    }
end
