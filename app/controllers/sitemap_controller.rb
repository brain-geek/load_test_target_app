class SitemapController < ApplicationController
  def index
    @pages = Refinery::Page.live.includes(:parts).order(:lft)
  end
end
