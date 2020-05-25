# frozen_string_literal: true

class Job
  class Application
    class Interview < ActiveRecord::Base
      belongs_to :application, class_name: Job::Application.name,
                               foreign_key: 'job_application_id'
      belongs_to :head_hunter
      has_one :job_seeker, through: :application
      has_one :job, through: :application

      validates :application, presence: true
      validates :head_hunter, presence: true
      validates :address, presence: true
      validates :date, presence: true
      validate :whether_date_is_a_datetime
      validate :whether_its_in_the_future

      default_scope -> { order date: :desc }

      private

      def whether_date_is_a_datetime
        return if date&.is_a? Time

        errors.add :date, :invalid
      end

      def whether_its_in_the_future
        return if date_is_in_the_future?

        errors.add :date, :retroactive
      end

      def date_is_in_the_future?
        date && date > DateTime.now
      end
    end
  end
end
