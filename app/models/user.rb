class User < ActiveRecord::Base

  validate :email, :uniqueness => true

  has_and_belongs_to_many :roles
  has_many :forum_posts

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable  and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :surname

  def role?(role)
    self.roles.where(:name => role.to_s.downcase).exists?
  end

  def name
    "#{firstname} #{surname}"
  end
end
