# frozen_string_literal: true

require 'rails_helper'

describe 'Logged-out Head Hunter' do
  scenario 'gets redirected when trying to create a job' do
    post head_hunters_jobs_path

    expect(response).to redirect_to(new_head_hunter_session_path)
  end
end
