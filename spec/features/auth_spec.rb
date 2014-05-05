require 'spec_helper'

describe "auth" do
  it "should let someone sign in" do
    visit root_path
    within('.nav') do
      click_on 'Sign In'
    end

    page.should have_content "Kevin Davis"
  end

  it "should let someone sign out" do
    test_sign_in

    visit root_path
    within('.nav') do
      click_on 'signout'
    end
  end
end