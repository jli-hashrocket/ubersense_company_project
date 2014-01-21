class Teammate < ActiveRecord::Base
	attr_accessible :account_id, :person_id

	belongs_to :account
	belongs_to :person

	validates :account_id, presence: true
	validates :person_id, presence: true, uniqueness: {scope: :account_id}

  class << self
    def add_teammate(current_user,teammate)
     name = teammate[:person][:name]
     email = teammate[:person][:email]
     person = Person.get_person_for_guid(Person.guid_construction(nil, email, nil, name), name, email)
     #person = Person.find_or_initialize_by(email: teammate[:person][:email])
     #person.name = teammate[:person][:name]
     #person.save
     teammate = Teammate.new(account_id: current_user.id, person_id: person.id)
     teammate.save
    end
  end
end
