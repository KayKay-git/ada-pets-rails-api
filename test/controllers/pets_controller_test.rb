require "test_helper"

describe PetsController do
  describe "index" do
    it "must get index" do
      get pets_path
      must_respond_with :success
    end

    it "responds with JSON and success" do
      get pets_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
  end
end
