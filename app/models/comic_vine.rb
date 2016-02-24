class ComicVine
  include HTTParty
  base_uri 'www.comicvine.com/api'
  default_params :format => 'json', :api_key => ENV['COMICVINE_KEY']
  headers 'User-Agent' => 'comics.sleekcoder.com'
  format :json

  def self.find_issue(id)
    Rails.logger.info "#{Time.now} ComicVine find issue #{id}"
    result = get("/issue/#{id}")
    Rails.logger.info "Result: #{result.code}"
    result
  end

  def self.find_volume(id)
    Rails.logger.info "#{Time.now} ComicVine find volume #{id}"
    result = get("/volume/#{id}")
    Rails.logger.info "Result: #{result.code}"
    result
  end

  def self.find_issues_by_volume(id)
    Rails.logger.info "#{Time.now} ComicVine find issues by volume #{id}"
    result = get("/issues?filter=volume:#{id}&field_list=id&sort=issue_number:desc")
    Rails.logger.info "Result: #{result.code}"
    result
  end
end
