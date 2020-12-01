require 'test_helper'

describe PetsController do
  required_pet_attrs = ['id', 'name', 'species', 'age', 'owner']

  describe 'index' do
    it 'must get index' do
      get pets_path
      must_respond_with :success
    end

    it 'responds with JSON and success' do
      get pets_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    # it 'will return all the proper fields for a list of pets ' do
    #   pet_fields = ["id", "name", "species", "age", "owner"].sort
    # end

    it 'responds with an array of pet hashes' do
      # Act
      get pets_path

      # Get the body of the response as an array or a hash
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array
      body.each do |pet|
        expect(pet).must_be_instance_of Hash

        required_pet_attrs = ['id', 'name', 'species', 'age', 'owner']

        expect(pet.keys.sort).must_equal required_pet_attrs.sort
      end
    end

    it 'will respond with an empty array when there are no pets' do
      # Arrange
      Pet.destroy_all

      # Act
      get pets_path
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
      expect(body.length).must_equal 0
    end


  end

  describe 'show' do

    # nominal
    it 'should return a hash with proper fields for an existing pet' do
      required_pet_attrs = ['id', 'name', 'species', 'age', 'owner'].sort

      pet = pets(:honey)

      # Act
      get pet_path(pet.id)

      body = JSON.parse(response.body)

      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'

      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal required_pet_attrs.sort

    end

    # edge case
    it 'should respond with not_found if no pet matches the id' do

      # Act
      get pet_path(-1)

      must_respond_with :not_found
      body = JSON.parse(response.body)

      # Then you can test for the json in the body of the response
      expect(body['ok']).must_equal false
      expect(body['message']).must_include 'Not Found'
    end

  end
end
