class ComicVine
  include HTTParty
  base_uri 'api.comicvine.com'
  default_params :format => 'json', :api_key => ENV['COMICVINE_KEY']
  format :json

  def self.find_issue(id)
    get("/issue/#{id}")
  end

  def self.find_volume(id)
    get("/volume/#{id}")
  end

  def self.find_issues_by_volume(id)
    get("/issues?filter=volume:#{id}&field_list=id")
  end
end
