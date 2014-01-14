require 'test_helper'

class CoachViewsTeammatesTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_sessions!
  end

  test 'show list of teammates' do
    coach = FactoryGirl.create(:account)
    teammates = FactoryGirl.create_list(:teammate, 3, account: coach)

    visit root_path

    fill_in 'account_email', with: coach.email
    fill_in 'account_password', with: 'password'

    click_button 'Login'

    teammates.each do |teammate|
      assert page.has_content?(teammate.person.name)
      assert page.has_content?(teammate.person.email)
    end
  end
end
