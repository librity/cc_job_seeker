class ChangeProfileDescriptionToBio < ActiveRecord::Migration[6.0]
  def change
    rename_column :job_seeker_profiles, :description, :bio
  end
end
