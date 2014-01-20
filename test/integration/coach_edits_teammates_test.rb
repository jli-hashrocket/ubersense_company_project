require 'test_helper'

class CoachEditsTeammateTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_sessions!
  end

  test 'edits teammate with valid information' do
    coach = FactoryGirl.create(:account)
    person = FactoryGirl.create(:person)

    sign_in_as(coach.email, 'password')

    fill_in 'teammate_person_name', with: person.name
    fill_in 'teammate_person_email', with: person.email

    click_button 'Add Teammate'
    click_link 'Edit'

    fill_in 'Name', with: 'Edward Scissorhands'
    fill_in 'Email', with: 'escissors@gmail.com'

    click_button 'Update Teammate'
    assert page.has_content?('Person has been updated')
  end

end
