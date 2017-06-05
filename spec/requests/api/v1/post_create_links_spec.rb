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

        link = JSON.parse(response.body)

        expect(link["url"]).to eq(params[:url])
        expect(link["title"]).to eq(params[:title])
    end

    it "post request doesn't have url and fails" do
        params = {
            title: "Google"
        }

        post '/api/v1/links', params

        expect(response.status).to be(500)

        error = JSON.parse(response.body)

        expect(error[0]).to eq("Url can't be blank")
    end
end