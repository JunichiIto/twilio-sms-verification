class AddVerificationColumnsToPresentEntry < ActiveRecord::Migration
  def change
    add_column :present_entries, :verification_code, :string
    add_column :present_entries, :verified, :boolean, null: false, default: false
  end
end
