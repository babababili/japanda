require 'dotenv'

module CanvasFactory
  Dotenv.load
  CANVAS_API_V1 ||= "#{ENV['CANVAS_API_HOST']}/api/v1"
  CANVAS_AUTH_HEADER ||= {
      Authorization: "Bearer #{ENV['CANVAS_API_TOKEN']}",
      content_type: 'application/json'
  }
  CANVAS_ACCOUNT_ID ||= ENV['CANVAS_ACCOUNT_ID']

  def self.perform_post(end_point, body)
    JSON.parse(RestClient.post end_point, body, CANVAS_AUTH_HEADER)
  end

  def self.perform_put(end_point, body)
    JSON.parse(RestClient.put end_point, body, CANVAS_AUTH_HEADER)
  end
end