require 'digest/sha1'

FactoryGirl.define do
	factory :account do
		email 'adam@gmail.com'
		hashed_pwd (Digest::SHA1.hexdigest 'password')
		first_name 'Adam'
		last_name 'Sheehan'
	end
end
