class Person < ActiveRecord::Base
	attr_accessible :account_id, :email, :fbid, :guId, :name

	belongs_to :account
	has_many :teammates

	validates :guId, presence: true, uniqueness: true

	validates_uniqueness_of :email

	validates_presence_of :name

	before_validation :assign_guid

	def guId(owner_account_id=nil)
		guid_attribute = read_attribute(:guId)
		return guid_attribute unless guid_attribute.blank?
		return Person.guid_construction(self.account_id, self.email, self.fbid, self.name, owner_account_id)
	end

	def name
		return read_attribute(:name) if self.account_id.blank?
		return self.account.name
	end

	class << self
		def get_person_for_guid(guId, name=nil, email=nil)
			if guId.to_i.to_s == guId.to_s
				# It's an account id sent in
				person = Person.where(account_id: guId).first
				return person if person

				account = Account.find(guId)
				person = Person.new(guId: guId, email: account.email, fbid: account.fbid, name: account.name, account_id: account.id)
				person.save!
				return person
			end

			type, identifier = guId.split(/:/)
			account = Account.where(type => identifier).first if %w(email fbid).include?(type)
			if account
				person = Person.where(account_id: account.id).first
				return person if person

				person = Person.where(type => identifier).first
				if person
					person.update_attributes(account_id: account.id)
					return person
				end

				name = account.name.blank? ? name : account.name
				person = Person.new(guId: account.id, account_id: account.id, name: name, email: account.email, fbid: account.fbid)
				person.save!
				return person
			end

			person = Person.where(guId: guId).first
			return person if person

			case type
			when 'fbid', 'email'
				person = Person.where(type => identifier).first
			end
			return person if person

			person = Person.new(guId: guId, name: name, email: email)
			if %w(email fbid).include?(type)
				person.send("#{type}=", identifier)
			end
			person.save!

			return person
		end

		def guid_construction(account_id, email, fbid, name, owner_account_id=nil)
			unless account_id.blank?
				return account_id
			end
			unless fbid.blank?
				return "fbid:#{fbid}"
			end
			unless email.blank?
				return "email:#{email}"
			end
			unless name.blank? || owner_account_id.blank?
				return "#{owner_account_id}:#{name.gsub(/ /, '')}"
			end
			raise Exception, "We can't build a guid without an email or fbid"
		end
	end

	private
	def assign_guid
		return unless self.guId.blank?
		self.guId = Person.guid_construction(self.account_id, self.email, self.fbid, self.name)
	end
end
