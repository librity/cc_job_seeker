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
FactoryBot.create_list :job_seeker, 10
# Job Seeker Profiles
JobSeeker.all.each { |job_seeker| FactoryBot.create :job_seeker_profile, job_seeker: job_seeker }

# Jobs
FactoryBot.create_list :job, 10, head_hunter: HeadHunter.first
FactoryBot.create_list :job, 5, :skip_validate, :expired, head_hunter: HeadHunter.first
FactoryBot.create_list :job, 5, :skip_validate, :expired

# Job Applications
FactoryBot.create_list :job_application, 5, job_seeker: JobSeeker.first, job: Job.first

# Job Offers
FactoryBot.create_list :job_application_offer, 2,
                       application: Job::Application.first
FactoryBot.create_list :job_application_offer, 1,
                       application: Job::Application.second
