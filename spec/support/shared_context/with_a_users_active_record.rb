# frozen_string_literal: true

RSpec.shared_context "with a users active record" do
  before(:all) do
    ActiveRecord::Base.connection.create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.boolean :admin, default: false, null: false
    end
  end

  after(:all) { ActiveRecord::Base.connection.drop_table :users }

  after { User.destroy_all }
end
