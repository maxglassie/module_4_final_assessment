require 'rails_helper'

describe "links API" do
  it "returns the links" do
    link1 = Link.create(url:"https://turing.io", title:"Turing")
    link2 = Link.create(url:"https://www.google.com", title:"Google")
    link3 = Link.create(url:"https://www.nytimes.com", title:"NYTimes")

    get '/api/v1/links'

    expect(response).to be_success

    links       = JSON.parse(response.body)
    link        = links.first

    expect(links.count).to eq(3)

    expect(link).to have_key "title"
    expect(link).to have_key "url"
    expect(link).to have_key "read"

    expect(link["title"]).to eq("Turing")
    expect(link["url"]).to eq("https://turing.io")
    expect(link["read"]).to eq(false)
  end
end