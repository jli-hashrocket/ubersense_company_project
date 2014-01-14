require 'test_helper'

class CoachAddsTeammateTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_sessions!
  end

  test 'add existing person as teammate' do
    coach = FactoryGirl.create(:account)
    person = FactoryGirl.create(:person)

    sign_in_as(coach.email, 'password')

    fill_in 'teammate_person_name', with: person.name
    fill_in 'teammate_person_email', with: person.email

    click_button 'Add Teammate'

    assert page.has_content?(person.name)
    assert page.has_content?(person.email)

    assert coach.teammates.count == 1
    assert coach.teammates.first.person.email == person.email

    assert Person.count == 1
  end
end
