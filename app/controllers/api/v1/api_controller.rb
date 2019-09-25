module Api::V1
  class ApiController < ApplicationController 
    include ActionController::Serialization
    include Knock::Authenticable
  end
end
