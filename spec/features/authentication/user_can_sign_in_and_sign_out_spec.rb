require 'rails_helper'

describe "user is able to login and logout" do
    context "when an a user visits the root path" do
      scenario "and they submit correct information and click on login" do
        user = User.create(
                         email: "we@the_best.com",
                         password: "password"
                         )
        visit root_path

        fill_in "Email", with: "we@the_best.com"
        fill_in "Password", with: "password"
        click_on "Login"

        expect(page).to have_content('Successfully logged in!')
        expect(current_path).to eq('/')
      end

      scenario "and they submit INcorrect information and click on login" do
        user = User.create(
                         email: "we@the_best.com",
                         password: "password"
                         )
        visit root_path

        fill_in "Email", with: "we@the_best.com"
        fill_in "Password", with: "batman"
        click_on "Login"

        expect(current_path).to eq('/login')
        expect(page).to have_content('Incorrect email and/or password')
      end
    end

    context "when a logged in user visits the index page" do
      scenario "and they click on Sign Out" do
        user = User.create(
                         email: "we@the_best.com",
                         password: "password"
                         )
        visit root_path

        fill_in "Email", with: "we@the_best.com"
        fill_in "Password", with: "password"
        click_on "Login"

        expect(current_path).to eq('/')
        expect(page).to have_content("Sign Out")
        click_on "Sign Out"

        expect(current_path).to eq('/login')
      end
    end
  end