require 'spec_helper'
require 'digest/sha1'

feature 'coach views teammate list', %q{
	As a coach
	I want to view a list of players on my team
	So that I can see my teammates
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
		expect(page).to have_button 'Add Teammate'
		expect(page).to have_content 'Email'
	end

	scenario 'form is submitted with no valid attributes' do

		visit root_path
		click_button 'Login'

		expect(page).to have_content 'Invalid email/password combination'
	end

end
