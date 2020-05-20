class AddStandoutToJobApplications < ActiveRecord::Migration[6.0]
  def change
    add_column :job_applications, :standout, :boolean, default: false
  end
end
