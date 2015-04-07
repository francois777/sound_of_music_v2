class ArticlesController < ApplicationController

  def user_for_paper_trail
    current_user if signed_in?
  end

end