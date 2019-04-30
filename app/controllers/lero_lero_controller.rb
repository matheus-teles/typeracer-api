require 'net/http'
require 'uri'

class LeroLeroController < ApplicationController

  def index
    @paragraph = paragraph.gsub(/<\/*p>/, "").split('.').first
    render json: { text: @paragraph }
  end

  def url
    URI("http://lerolero.miguelborges.com/paragraphs/1")
  end

  def paragraph
    response = Net::HTTP.post(url, '')
    response.body.force_encoding('utf-8')
  end
end