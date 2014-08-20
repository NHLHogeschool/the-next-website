require 'open-uri'

class StaticPagesController < ApplicationController
  GUIDE_URL = 'https://raw.githubusercontent.com/NHLHogeschool/the-next-web/master/README.md'

  def guide
    # TODO: Add caching
    @title = 'Handboek'
    @body  = open(GUIDE_URL).read
    render :show
  end

  def callback
    render text: request.env['omniauth.auth'].to_hash.inspect
  end
end
