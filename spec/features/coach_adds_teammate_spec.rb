require 'spec_helper'
require 'digest/sha1'

feature 'coach adds teammate to list', %q{
	As a coach
	I want add a player
	So that I can update the team member list
	} do

	# Acceptance Criteria
	# I must navigate to the index page
	# I must click on the add button
	# I must fill in first name and last name
	# I could fill in email
	# I must click submit

	scenario 'coach adds a teammate' do

		visit root_path
		password = Digest::SHA1.hexdigest 'password'
		account = Account.create!(email: 'adamsbomb@gmail.com', hashed_pwd: password , first_name: 'Adam', last_name: 'Sheehan')

		person = FactoryGirl.create(:person)

		visit root_path
		
		fill_in 'account_email', with: account.email
		fill_in 'account_password', with: 'password'

		click_button 'Login'
		
		fill_in 'teammate_people_name', with: person.name
		fill_in 'teammate_people_email', with: person.email

		click_button 'Add Teammate'
	
		expect(page).to have_content "#{person.name} Added to the team!"

	end
end