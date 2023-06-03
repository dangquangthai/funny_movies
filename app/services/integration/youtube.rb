# frozen_string_literal: true

module Integration
  class Youtube
    attr_reader :title, :description, :source_id, :source_url

    def initialize(source_url:)
      @source_url = source_url
      @source_id = Video::YOUTUBE_URL_REGEX.match(source_url).try(:captures)&.first
    end

    def perform
      return false if source_id.blank?
      return false if sanitized_title.blank?

      @title = sanitized_title
      @description = html_document.at("meta[name='description']")&.[]('content')

      true
    end

    protected

    def sanitized_title
      @sanitized_title ||= html_document.at_css('title')&.text&.gsub(' - YouTube', '')
    end

    def html_document
      @html_document ||= Nokogiri::HTML(html_content)
    end

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
