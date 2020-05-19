# frozen_string_literal: true

require 'rails_helper'

feature "Head Hunter can browse comments on an applicant's profile" do
  context 'when logged-in' do
    let!(:head_hunter) { log_head_hunter_in! }

    scenario 'successfully' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      profile = create :job_seeker_profile, job_seeker: applicant
      comment_a = create :job_seeker_profile_comment, job_seeker_profile: profile
      comment_b = create :job_seeker_profile_comment, job_seeker_profile: profile
      comment_c = create :job_seeker_profile_comment, job_seeker_profile: profile
      create :job_application, job: job_a, job_seeker: applicant

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on applicant.resolve_name

      expect(page).to have_content I18n.t('activerecord.models.job_seeker/profile/comments.other')
      expect(page).to have_content comment_a.content
      expect(page).to have_content l(comment_a.created_at)
      expect(page).to have_content comment_a.head_hunter.resolve_name

      expect(page).to have_content comment_b.content
      expect(page).to have_content l(comment_b.created_at)
      expect(page).to have_content comment_b.head_hunter.resolve_name

      expect(page).to have_content comment_c.content
      expect(page).to have_content l(comment_c.created_at)
      expect(page).to have_content comment_c.head_hunter.resolve_name
    end

    scenario 'and job has no applications' do
      job_a = create :job, head_hunter: head_hunter
      applicant = create :job_seeker
      create :job_seeker_profile, job_seeker: applicant
      create :job_application, job: job_a, job_seeker: applicant

      visit root_path
      click_on I18n.t('activerecord.models.job.other')
      within "tr#job-#{job_a.id}" do
        click_on I18n.t('views.navigation.details')
      end
      click_on applicant.resolve_name

      expect(page).to have_content I18n.t('views.job_seekers/profiles/comments.empty_resource')
    end
  end
end
