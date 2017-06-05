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

  scenario "and submit a link and title" do
    visit "/"

    within('#link-create') do
        fill_in "link-url", with: "https://www.google.com"
        fill_in "link-title", with: "Google"
        click_on("Add Link")
    end

    expect(current_path).to eq('/')

    expect(page).to have_content("https://www.google.com")
    expect(page).to have_content("Google")
  end

  scenario "and submit a link and title" do
    visit "/"

    within('#link-create') do
        fill_in "link-url", with: "https://www.google.com"
        click_on("Add Link")
    end

    expect(current_path).to eq('/')

    expect(page).to have_content("Url can't be blank")
  end
end