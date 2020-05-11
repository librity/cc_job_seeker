# frozen_string_literal: true

module HeadHunters
  class BaseController < ApplicationController
    before_action :authenticate_head_hunter!
  end
end
