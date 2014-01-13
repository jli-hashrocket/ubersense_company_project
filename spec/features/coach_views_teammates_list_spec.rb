require 'spec_helper'
require 'digest/sha1'

feature 'coach views teammate list', %q{
	As a coach
	I want to a view a list of players on my team
	So that I can verify that they've been added
} do

# 	Acceptance Criteria:
# * I must be authenticated to view the players list
# * Each player lists a first name, last name, and email
# * "View Players" links to player list

	scenario 'coach sees full list of teammates' do
		 password = Digest::SHA1.hexdigest 'password'
		 account = Account.create!(email: 'adamsbomb@gmail.com', hashed_pwd: password , first_name: 'Adam', last_name: 'Sheehan')

		visit root_path
		
		fill_in 'account_email', with: account.email
		fill_in 'account_password', with: 'password'

		click_button 'Login'
		
		expect(page).to have_content 'Team'
		expect(page).to have_button 'Add Player'
		expect(page).to have_content 'Email'
	end

end