class StaticPagesController < ApplicationController

  def help
  end

  def about
  end

  def research
  end

  def ssl_validation
	  send_file(
	    "#{Rails.root}/public/15CAA848590025BB3B93F642928894E0.txt",
	    filename: "15CAA848590025BB3B93F642928894E0.txt",
	    type: "text/plain"
	  )
  end
end
