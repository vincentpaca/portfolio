class HomeController < ApplicationController
  def index
    @ip = request.env["HTTP_X_FORWARDED_FOR"] || "127.0.0.1"
  end
end
