class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  private

  def current_result
  	Result.find(session[:result_id])
  rescue ActiveRecord::RecordNotFound
  	result = Result.create
  	session[:result_id] = result.id
  	result
  end
end
