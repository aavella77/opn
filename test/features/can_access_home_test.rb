require "test_helper"
include Warden::Test::Helpers
Warden.test_mode!

feature "CanAccessHome" do

  def setup
    @user = users(:user_1)
  end

  scenario "logged out homepage loads" do
    visit root_path
    page.must_have_content "Movement to Solve"
    #page.wont_have_content "Goobye All!"
  end

  scenario "user can log in" do
    visit new_user_session_path
    page.must_have_content "Not yet a Member? Join."

    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => "password"
    click_button 'Sign in'

    page.must_have_content @user.name
  end

  scenario "user can log out" do
    login_as(@user, :scope => :user)
    visit research_topics_path
    page.must_have_content @user.name
    click_on 'Sign out'
    page.must_have_content "Sign in"

  end


end


