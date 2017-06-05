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

  scenario "click on the edit button and reach the edit page" do
    visit "/"

    within('#tb-links') do
        click_on("Edit")
    end

    expect(current_path).to eq('/links/1/edit')
  end
end