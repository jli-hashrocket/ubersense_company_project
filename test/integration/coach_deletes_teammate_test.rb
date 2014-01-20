require 'test_helper'

class CoachDeletesTeammateTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_sessions!
  end

  test 'deletes teammate' do
    coach = FactoryGirl.create(:account)
    person = FactoryGirl.create(:person)

    sign_in_as(coach.email, 'password')

    fill_in 'teammate_person_name', with: person.name
    fill_in 'teammate_person_email', with: person.email

    click_button 'Add Teammate'

    click_link 'Delete'
    assert page.has_content?('Person has been deleted')
    assert !page.has_content?(person.name && person.email)
  end

end
