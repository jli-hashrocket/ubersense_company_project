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

  test 'should not update name if duplicate email' do
    coach = FactoryGirl.create(:account)
    person = FactoryGirl.create(:person)

    sign_in_as(coach.email, 'password')

    fill_in 'teammate_person_name', with: person.name
    fill_in 'teammate_person_email', with: person.email

    click_button 'Add Teammate'

    fill_in 'teammate_person_name', with: 'John Smith'
    fill_in 'teammate_person_email', with: person.email

    click_button 'Add Teammate'

    assert !page.has_content?('John Smith')
    assert page.has_content?(person.name)
    assert page.has_content?(person.email)
    assert page.has_content?('Teammate Not Added!')
  end

  test 'adds person with an existing account to team' do
    existing_account = FactoryGirl.create(:account)
    coach = FactoryGirl.create(:account)

    sign_in_as(coach.email, 'password')

    fill_in 'teammate_person_name', with: existing_account.name

    fill_in 'teammate_person_email', with: existing_account.email

    click_button 'Add Teammate'

    assert page.has_content?(existing_account.name)
    assert page.has_content?(existing_account.email)

  end

end
