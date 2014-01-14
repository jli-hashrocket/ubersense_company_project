require 'digest/sha1'
require 'csv'

class Account < ActiveRecord::Base
  attr_accessor :password

	attr_accessible :hashed_pwd
	attr_accessible :email
	attr_accessible :first_name
	attr_accessible :last_name
	attr_accessible :password

    validates_length_of :first_name, :maximum => 100
    validates_length_of :last_name, :maximum => 100
	validates :email, presence: true, uniqueness: true, format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :password, format: {:with => /\A[a-z0-9A-Z!\#$%&'*+\/=?^_`{|}~-]{6,}\z/}, :if => Proc.new {|a| a.password && a.fbid.blank? }
  
	has_many :teammates
	has_many :people, through: :teammates

	before_validation :downcase_email

  
	def name
		"#{self.first_name} #{self.last_name}"
	end

  def validate_login
    Account.login(self.email, self.password)
  end

	def self.get_hashed_pwd(pwd)
		return nil if pwd.blank?
	  hash_password(pwd)
	end

	def self.login(email, password)
	  hashed_password = hash_password(password || "")
	  find(:first, :conditions => ["email = ? and hashed_pwd = ?", email, hashed_password])
	end

  def self.add_players_from_file(current_user, file_path)
    csv_file = file_path
    CSV.foreach(csv_file, headers: true) do |row|
      name = row["name"]
      email = row["email"]
      if person = Person.find_or_create_by(name: name, email: email)
        Teammate.create(account_id: current_user.id, person_id: person.id)
      end
    end
  end

  private

	def downcase_email
		self.email = self.email.downcase if self.email
	end
  
  def self.hash_password(password)
    Digest::SHA1.hexdigest(password)
  end
end
