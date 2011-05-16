class Product < ActiveRecord::Base
  default_scope :order => 'title'
  
  validates :title, :description, :image_url, :presence => true
  validates :title, :uniqueness => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :image_url, :format => {
                                      :with => %r{\.(jpeg|jpg|gif|png)$}i,
                                      :message => 'Verify your image type'
                                    }
                                    
                                    
  has_many :line_items
  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  
  private 
  def ensure_not_referenced_by_any_line_item
    
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line items present')
      return false
    end
    
  end

end
