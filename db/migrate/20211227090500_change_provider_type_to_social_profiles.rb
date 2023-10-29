class ChangeProviderTypeToSocialProfiles < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :social_profiles do |t|
        dir.up do
          t.change :provider, "integer USING CAST(provider AS integer)"
        end

        dir.down do
          t.change :provider, :string
        end
      end
    end
  end
end
