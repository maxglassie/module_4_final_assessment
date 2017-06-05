class Link < ActiveRecord::Base
  validates :url, presence: :true, http_url: :true
  validates :title, presence: :true
end
