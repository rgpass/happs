class StaticPagesController < ApplicationController
  def home
  	redirect_to user_path(current_user) if current_user
  end

  def help
  end

  def about
  end

  def research
  end
end
