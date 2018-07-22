class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


has_many :user_stocks
has_many :stocks, through: :user_stocks
has_many :friendships
has_many :friends, through: :friendships

def full_name
	return "#{first_name} #{last_name}" if (first_name || last_name)
	"Anonymus" 
end

end
