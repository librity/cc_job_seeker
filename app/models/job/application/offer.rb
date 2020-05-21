# frozen_string_literal: true

class Job
  class Application
    class Offer < ActiveRecord::Base
      belongs_to :application, class_name: Job::Application.name,
                               foreign_key: 'job_application_id'
      belongs_to :head_hunter

      enum status: { ongoing: 0, accepted: 1, rejected: 2 }

      validates :application, presence: true
      validates :head_hunter, presence: true
      validates :start_date, presence: true, format: { with: ApplicationHelper::DATE_REGEX }
      validate :whether_it_starts_in_the_future
      validates :salary,
                presence: true,
                numericality: { only_integer: true,
                                greater_than_or_equal_to: BRAZILIAN_MINIMUM_WAGE }
      validates :responsabilities, presence: true, length: { minimum: 50 }
      validates :benefits, presence: true, length: { minimum: 50 }

      default_scope -> { order created_at: :desc }

      private

      def whether_it_starts_in_the_future
        return if start_date_is_in_the_future?

        errors.add :start_date, :retroactive
      end

      def start_date_is_in_the_future?
        start_date && start_date > Date.today
      end
    end
  end
end
