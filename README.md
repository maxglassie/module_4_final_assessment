# URLockBox

## Final Assessment

The URLockbox is a starter app for the final assessment for module 4 of the backend engineering program at Turing School of Software and Design.

Max Glassie did this particular final assessment. The final production link on Heroku is here: (https://salty-peak-54308.herokuapp.com/login)

*A broad overview of features:*
- The application enables the authentication and authorization of users (you can create an account and login)
- Once logged in, a user can create links and add them to their list.
- Users can filter their lists by their title and their "read" or "unread" status.
- When a user marks their link as read, it sends a POST request to the companion application, Hot Reads, at this URL (https://arcane-eyrie-99827.herokuapp.com/) where it is ranked against all the URLs that have been submitted and displayed on the main page.
- The Hot Reads app communicates with this main app to indicate whether or not the link is the "Top Link" or within the top ten ("Hot")
- The application has wonderful error handling, including a custom validation for whether or not the URL is a valid URL. 
- The main application is a Rails application which incorporates significant JS to handle front end actions. The companion app is just plain Rails. 

# Running the Application Locally

### Testing your JS with Selenium

The app has the `selenium-webdriver` gem listed in the `Gemfile` and setup in the `rails_helper.rb`

#### Setup

Everything will be installed with Bundle.

You will need to download version 46 of Firefox [here](https://www.softexia.com/windows/web-browsers/firefox-46). If you do have it, make sure it is on version 46. Selenium does not work with all versions of Firefox, so make sure that you are using Firefox 46 or else it will potentially cause you problems.

If you already have Firefox and it's on a version more recent than 46, the easiest way to downgrade is to uninstall Firefox then install version 46.

#### Use

You can then write capybara feature tests and add `js: true` tag if you'd like your test to use the Selenium WebDriver rather than the default WebDriver.  Your tests will execute and recognize your JavaScript.

If you're having problems troubleshooting asynchronous actions (like DOM changes after an AJAX request), [peruse this section of Capybara's docs](https://github.com/teamcapybara/capybara#asynchronous-javascript-ajax-and-friends)

It is highly suggested that you also check out the Capybara docs and and the section on [selenium-webdriver](https://github.com/teamcapybara/capybara#selenium).
