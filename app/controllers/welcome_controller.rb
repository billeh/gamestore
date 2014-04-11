class WelcomeController < ApplicationController
  before_filter :check_that_user_signed_in


  def index
  end

end
