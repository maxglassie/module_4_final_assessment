require 'rails_helper'

describe "User can create an account" do


    context "when an UNauthenticate user visits the root path" do
      scenario "and they click on sign up" do
          visit root_path

          expect(current_path).to eq('/login')
          expect(page).to have_content("Login")
          expect(page).to have_content("Sign Up by clicking here")
      end
    end

    context "when they click on sign up" do
      scenario "and fill in all necessary fields" do
        visit root_path

        click_on "Sign Up"

        expect(current_path).to eq(new_user_path)

        fill_in "user[email]", with: "we@thebest.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_on "Sign Up"

        expect(current_path).to eq(root_path)

        expect(page).to have_content "Sign Out"
      end
    end

    context "when they click on create account" do
      scenario "and their email address is already registered" do
        user = User.create(
                           email: "we@the_best.com",
                           password: "password"
                           )
        visit new_user_path

        fill_in "user[email]", with: "we@the_best.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_on "Sign Up"

        expect(page).to have_content("Email is already registered!")
        expect(current_path).to eq(new_user_path)
      end

      scenario "and the password is blank" do
        visit new_user_path

        fill_in "user[email]", with: "we@the_best.com"
        fill_in "user[password]", with: ""
        fill_in "user[password_confirmation]", with: "password"
        click_on "Sign Up"

        expect(page).to have_content("Password cannot be blank")
        expect(current_path).to eq(new_user_path)
      end

      scenario "and the password confirmation is blank" do
        visit new_user_path

        fill_in "user[email]", with: "we@the_best.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: ""
        click_on "Sign Up"

        expect(page).to have_content("Password confirmation cannot be blank")
        expect(current_path).to eq(new_user_path)
      end

      scenario "and password and password_confirmation are not equal" do
        visit new_user_path

        fill_in "user[email]", with: "we@the_best.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "pass"
        click_on "Sign Up"

        expect(page).to have_content("Password confirmation and password do not match")
        expect(current_path).to eq(new_user_path)
      end
    end
  end