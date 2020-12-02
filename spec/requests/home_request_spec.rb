require 'rails_helper'

RSpec.describe "Home", type: :request do


  describe "GET #top" do
    it "topにアクセスすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq 200
    end
  end
end
