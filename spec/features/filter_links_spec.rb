require 'rails_helper'

#Selenium is not working properly. It works in the browser.
#I discussed this with Casey and she said keep moving.
RSpec.describe "User can visit the index page", :js => :true do
  before(:each) do
      user = User.create(
                         email: "we@thebest.com",
                         password: "password"
                         )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario "and filter the links" do
    link1 = Link.create(url:"https://turing.io", title:"Turing")
    link2 = Link.create(url:"https://www.google.com", title:"Google", read: "true")

    visit "/"

    within('#filter-box') do
        fill_in "input-field", with: "g"
    end

    expect(page).to have_content("https://www.google.com")
    expect(page).to have_content("Google")

    expect(page).to_not have_content("https://www.turing.io")
    expect(page).to_not have_content("Turing")
  end

  scenario "and filter the links by read" do
    link1 = Link.create(url:"https://turing.io", title:"Turing")
    link2 = Link.create(url:"https://www.google.com", title:"Google", read: "true")

    visit "/"

    within('#filter-box') do
        click_on "Only Read Links"
    end

    expect(page).to have_content("https://www.google.com")
    expect(page).to have_content("Google")

    expect(page).to_not have_content("https://www.turing.io")
    expect(page).to_not have_content("Turing")
  end
end