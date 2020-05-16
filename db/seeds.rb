# frozen_string_literal: true

# Head Hunters
demo_head_hunter = HeadHunter.create! email: 'head_hunter@example.com',
                                       password: '12345678',
                                       name: 'Heady Hunterburg'

10.times do |_n|
  FactoryBot.create :head_hunter
end

# Job Seekers
demo_job_seeker = JobSeeker.create! email: 'job_seeker@example.com',
                                     password: '12345678',
                                     name: 'Jobby Seekersky'

# Jobs
10.times do |_n|
  FactoryBot.create :job_seeker
end

10.times do |_n|
  FactoryBot.create :job, head_hunter: demo_head_hunter
end

5.times do |_n|
  FactoryBot.create :job, :skip_validate, :expired, head_hunter: demo_head_hunter
end

5.times do |_n|
  FactoryBot.create :job
end

5.times do |_n|
  FactoryBot.create :job, :skip_validate, :expired
end
