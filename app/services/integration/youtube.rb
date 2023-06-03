# frozen_string_literal: true

module Integration
  class Youtube
    attr_reader :title, :description, :source_id

    def initialize(source_id:)
      @source_id = source_id
    end

    def fetch
      return if source_id.blank?

      doc = Nokogiri::HTML(html_content)
      @title = doc.at_css('title')&.text&.gsub(' - YouTube', '')
      @description = doc.at("meta[name='description']")&.[]('content')
    end

    protected

    def html_content
      uri = URI.parse("https://www.youtube.com/watch?v=#{source_id}")
      request = Net::HTTP::Get.new(uri.to_s)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request request
      end
      response.body
    end
  end
end
