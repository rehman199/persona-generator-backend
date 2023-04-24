class PersonaController < ApplicationController

  def index
      
  end

  def create
    persona = Persona.new(description: ChatgptService.get_response(params[:message]))
    
    if persona.save
      render json: persona, status: :ok
    else
      render json: { errors: "Couldn't generate persona" }, status: :unprocessable_entity
    end
  end

  def show

  end

  def destroy

  end
end
