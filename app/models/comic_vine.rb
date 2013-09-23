class ComicVine
  include HTTParty
  base_uri 'api.comicvine.com'
  default_params :format => 'json', :api_key => ENV['COMICVINE_KEY']
  format :json

  def self.find_issue(id)
    get("/issue/#{id}")    
  end

  def self.find_person(id)
    get("/person/#{id}")
  end

  def self.find_character(id)
    get("/character/#{id}")    
  end

  def self.find_volume(id)
    get("/volume/#{id}")    
  end

  def self.find_publisher(id)
    get("/publisher/#{id}")    
  end
end