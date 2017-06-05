require "rails_helper"

RSpec.describe "User can edit a link on the edit page" do
  before(:each) do
      user = User.create(
                         email: "we@thebest.com",
                         password: "password"
                         )

      @link1 = Link.create(url:"https://turing.io", title:"Turing")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario "correctly fills in form on the edit page and clicks submit" do
    visit "/links/1/edit"

    fill_in "URL", with: "http://www.google.com"
    fill_in "Title", with: "Google"
    click_on "Update Link"

    expect(current_path).to eq("/")
  end

  scenario "leaves url blank" do
    visit "/links/2/edit"

    fill_in "URL", with: ""
    fill_in "Title", with: "Google"
    click_on "Update Link"

    expect(current_path).to eq("/links/2/edit")
    expect(page).to have_content("Url can't be blank")
  end

  scenario "url invalid" do
    visit "/links/3/edit"

    fill_in "URL", with: "not valid"
    fill_in "Title", with: "Google"
    click_on "Update Link"

    expect(current_path).to eq("/links/3/edit")
    expect(page).to have_content("Url is not a valid HTTP URL")
  end

  scenario "title blank" do
    visit "/links/4/edit"

    fill_in "URL", with: "not valid"
    fill_in "Title", with: "Google"
    click_on "Update Link"

    expect(current_path).to eq("/links/4/edit")
    expect(page).to have_content("")
  end
end