# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    return redirect_to head_hunters_dashboard_path if head_hunter_signed_in?
  end
end
