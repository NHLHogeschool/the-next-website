require 'open-uri'

class StaticPagesController < ApplicationController
  GUIDE_URL = 'https://raw.githubusercontent.com/NHLHogeschool/the-next-web/master/README.md'

  def guide
    @body  = open(GUIDE_URL).read
    render :show
  end
end
