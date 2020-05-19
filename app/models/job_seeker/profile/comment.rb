# frozen_string_literal: true

class JobSeeker
  class Profile
    class Comment < ActiveRecord::Base
      belongs_to :profile, class_name: JobSeeker::Profile.name,
                           foreign_key: 'job_seeker_profile_id'
      belongs_to :head_hunter

      validates :profile, presence: true
      validates :head_hunter, presence: true
      validates :content, presence: true, length: { minimum: 50 }
    end
  end
end
