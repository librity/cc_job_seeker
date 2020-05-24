# frozen_string_literal: true

require 'rails_helper'

feature 'Job Seeker can view their profile' do
  context 'when logged-in' do
    let!(:job_seeker) { log_job_seeker_in! }

    scenario 'and shows comments' do
      comments = create_list :job_seeker_profile_comment, 5, profile: job_seeker.profile

      visit root_path
      click_on I18n.t('activerecord.models.job_seeker/profile.my_profile')

      expect(current_path).to eq seeker_show_profile_path
      expect(page).to have_content I18n.t('activerecord.models.job_seeker/profile/comment.other')
      comments.each do |comment|
        expect(page).to have_content comment.content
        expect(page).to have_content I18n.l(comment.created_at, format: :long)
        expect(page).to have_content comment.head_hunter.resolve_name
      end
    end

    scenario 'and announces empty comments' do
      visit root_path
      click_on I18n.t('activerecord.models.job_seeker/profile.my_profile')

      expect(current_path).to eq seeker_show_profile_path
      expect(page).to have_content I18n.t('views.job_seekers/profiles/comments.empty_resource')
    end
  end
end
