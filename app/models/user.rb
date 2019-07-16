class User < ActiveRecord::Base

  has_secure_password
  has_many :reviews
  validates_presence_of :email, :first_name, :last_name
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    user && user.authenticate(password)
  end

end
