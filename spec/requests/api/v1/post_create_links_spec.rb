require 'rails_helper'

describe "links API" do
    it "post request creates a new link" do
        params = {
            url: "https://www.google.com",
            title: "Google",
        }

        post '/api/v1/links', params

        expect(response).to be_success
        expect(response.status).to be(201)
      end
end