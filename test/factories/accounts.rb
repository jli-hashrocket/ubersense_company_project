require 'digest/sha1'

FactoryGirl.define do
  factory :account do
    email 'bob.lob@loblaw.com'
    hashed_pwd (Digest::SHA1.hexdigest 'password')
    first_name 'Bob'
    last_name 'Lob'
  end
end
