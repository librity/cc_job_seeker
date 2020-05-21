class AddHeadHunterToJobApplicationOffer < ActiveRecord::Migration[6.0]
  def change
    add_reference :job_application_offers, :head_hunter, null: false, foreign_key: true
  end
end
