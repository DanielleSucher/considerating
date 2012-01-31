class User < ActiveRecord::Base
	attr_accessor :name
	has_many :considerations

	def self.create_with_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.name = auth["info"]["name"]
		end
	end
end
