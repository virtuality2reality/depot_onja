class User < ActiveRecord::Base   

  after_destroy :ensure_an_admin_remains  
  attr_accessor   :password
  before_save :encrypt_password
  
  validates :name, :presence => true, :uniqueness => true  
  validates :password, :confirmation => true      
  
  def encrypt_password
    if password.present?      
      self.salt = BCrypt::Engine.generate_salt
      self.hashed_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end
  
  def self.authenticate(name, password)
    user = find_by_name(name)
    if user && user.hashed_password ==  BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end
  
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end 
  
end