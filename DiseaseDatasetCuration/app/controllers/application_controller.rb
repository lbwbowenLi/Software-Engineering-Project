class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def reason_to_index(str)
    case str
    when "Comprehensive"
      return 1
    when "Irrelevant Study"
      return 2
    when "Not Enough Experiment"
      return 3
    when "No health Control"
      return 4
    when "Micro RNA"
      return 5
    when "Biomarker"
      return 6
    when "Others"
      return 7
    end
  end

  def choose_to_bool(str)
  	if str == "1"
  		return true
  	else
  		return false
  	end
  end

  def update_session(page, search, sort)
    # byebug
    if !params.has_key?(page)
      if !params.has_key?(search) && !params.has_key?(sort)
        session.delete(search) if session.has_key? search
        session.delete(sort) if session.has_key? sort
      end

      if params.has_key? search
        session[search] = params[search]
      end

      if params.has_key? sort
        _sort = params[sort] # session[sort] = ["id", true], where true => descending while false => ascending
        if session.has_key?(sort) && session[sort][0] == _sort
          session[sort][1] = !session[sort][1]
        else
          session[sort] = [_sort, true]
        end
      end
    end
  end

end
