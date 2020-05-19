class AddTimestampsToMissingTables < ActiveRecord::Migration[6.0]
  def change
    change_table :job_seeker_profiles do |t|
      t.timestamps
    end

    change_table :job_applications do |t|
      t.timestamps
    end

    change_table :job_seeker_profile_comments do |t|
      t.timestamps
    end

    change_table :job_seeker_profile_favorites do |t|
      t.timestamps
    end
  end
end
