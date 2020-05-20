class AddRejectionFeedbackToJobApplications < ActiveRecord::Migration[6.0]
  def change
    add_column :job_applications, :rejection_feedback, :text
  end
end
