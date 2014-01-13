class Teammate < ActiveRecord::Base
	attr_accessible :account_id, :person_id

	belongs_to :account
	belongs_to :person

	validates :account_id, presence: true
	validates :person_id, presence: true, uniqueness: {scope: :account_id}

end
