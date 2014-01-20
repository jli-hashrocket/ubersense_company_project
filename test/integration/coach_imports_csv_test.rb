require 'test_helper'

class CoachImportsCsvTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.reset_sessions!
  end

  test 'should import valid csv' do
    coach = FactoryGirl.create(:account)
    sign_in_as(coach.email, 'password')

    page.find("#file").click
    attach_file "file", Rails.root.to_s + '/test/sample_csv/sample.csv'
    click_button("Import CSV")

    assert page.has_content?('CSV uploaded, and teammates added!')
    assert page.has_content?('test@gmail.com')
  end

  test 'should not import invalid file type' do
    coach = FactoryGirl.create(:account)
    sign_in_as(coach.email, 'password')

    page.find("#file").click
    attach_file "file", Rails.root.to_s + '/test/sample_csv/sample.rtf'
    click_button("Import CSV")

    assert page.has_content?("Sorry invalid file type!")
    assert page.has_content?("Team Name")
  end

  test 'should not import invalid headers' do
    coach = FactoryGirl.create(:account)
    sign_in_as(coach.email, 'password')

    page.find("#file").click
    attach_file "file", Rails.root.to_s + '/test/sample_csv/invalid_headers.csv'
    click_button("Import CSV")

    assert page.has_content?("Sorry invalid headers!")
    assert page.has_content?("Team Name")
  end

  # test 'not import duplicate teammates'

  # test 'updates name if duplicate email'

  # test 'submit form without adding CSV'

end
