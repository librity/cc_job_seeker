# frozen_string_literal: true

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Head Hunters
FactoryBot.create :head_hunter,
                  email: 'head_hunter@example.com',
                  password: '12345678',
                  name: 'Heady Hunterburg'
FactoryBot.create_list :head_hunter, 10

# Job Seekers
FactoryBot.create :job_seeker,
                  email: 'job_seeker@example.com',
                  password: '12345678',
                  name: 'Jobby Seekersky'
sample_job_seekers = FactoryBot.create_list :job_seeker, 10
# Job Seeker Profiles
sample_job_seekers.each { |job_seeker| FactoryBot.create :job_seeker_profile, job_seeker: job_seeker }

# Jobs
FactoryBot.create_list :job, 10, head_hunter: HeadHunter.first
FactoryBot.create_list :job, 5, :skip_validate, :expired, head_hunter: HeadHunter.first
FactoryBot.create_list :job, 5, :skip_validate, :expired
