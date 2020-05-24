# frozen_string_literal: true

module Hunter
  class BaseController < ApplicationController
    before_action :authenticate_head_hunter!
  end
end
