require "rails_helper"

RSpec.describe "User can visit the index page", :js => :true do
  before(:each) do
      user = User.create(
                         email: "we@thebest.com",
                         password: "password"
                         )

      link1 = Link.create(url:"https://turing.io", title:"Turing")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario "and see a list of existing links" do
    visit "/"

    within('#link-form') do
        expect(page).to have_content("Turing")
        expect(page).to have_content("https://turing.io")
        expect(page).to have_content("Read?: false")
    end
  end

  xscenario "and submit a new link and title" do
    visit "/"

    within('#link-form') do
        fill_in "link[url]", with: "we@thebest.com"
        fill_in "link[title]", with: "password"
        click_on "Save Link"
    end
  end
end