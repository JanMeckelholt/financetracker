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
		if (first_name || last_name)
		  return "#{first_name} #{last_name}" 
		else
			"Anonymus"
		end 
	end

	def self.search_friends(search_input)
		r = (search_by_field("email", search_input) + search_by_field("first_name", search_input) + search_by_field("last_name", search_input)).uniq
		if r 
			return r
		else
		  return nil
		end
	end

	def self.search_by_field(fieldname, search_input)
		r = where("#{fieldname} like?", "%#{search_input}%")
	end

end
