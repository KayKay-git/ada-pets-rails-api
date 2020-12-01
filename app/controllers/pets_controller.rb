class PetsController < ApplicationController
  def index
    # @pets = Pet.all.order(:name)
    # Notice, I dont need an @ symbol bc no view to share it with.
    pets = Pet.all.order(:name) # putting .as_json(only: [:id, :name, :age, :owner, :species]) passes when done here also.
    render json: pets.as_json(only: [:id, :name, :age, :owner, :species]), status: :ok
    # or exclude --> render json: pets.as_json(except: [:created_at, :updated_at]), status: :ok

  end

  def show
    pet = Pet.find_by(id: params[:id])

    if pet.nil?
      render json: {
          ok: false,
          message: 'Not Found'    # message is case sensitive, so know that when testing it must match exactly.
      }, status: :not_found
      return
    end

    render json: pet.as_json(only: [:id, :name, :age, :owner, :species]), status: :ok
  end
end
