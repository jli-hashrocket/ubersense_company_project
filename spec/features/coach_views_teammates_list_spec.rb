require 'spec_helper'

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
	it "should show teammates info" do
		visit root_path

		
		visit teammates_path



		expect(page).to have_content 

	end
end

end