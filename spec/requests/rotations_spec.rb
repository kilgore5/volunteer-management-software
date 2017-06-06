require 'rails_helper'

RSpec.describe "Rotations", type: :request do
  describe "GET /rotations" do
    it "works! (now write some real specs)" do
      get rotations_path
      expect(response).to have_http_status(200)
    end
  end
end
