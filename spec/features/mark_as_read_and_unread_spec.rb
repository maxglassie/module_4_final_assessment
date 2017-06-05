require "rails_helper"

#this passes!
RSpec.describe "can mark links as read and unread", :js => :true do
    before(:each) do
      user = User.create(
                         email: "we@thebest.com",
                         password: "password"
                         )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario "Mark a link as read" do
    Link.create(url:"https://turing.io", title:"Turing")
    visit "/"

    within('#tb-links #link-read') do
      expect(page).to have_text("false")
    end

    within('#tb-links #mark-read') do
      click_on "Mark As Read"
    end

    within('#tb-links #link-read') do
      expect(page).to have_text("true")
    end
  end

  scenario "Mark a link as read" do
    Link.create(url:"https://turing.io", title:"Turing", read: true)
    visit "/"
    
    within('#tb-links #link-read') do
      expect(page).to have_text("true")
    end

    within('#tb-links #mark-unread') do
      click_on "Mark As Unread"
    end

    within('#tb-links #link-read') do
      expect(page).to have_text("false")
    end
  end
end
