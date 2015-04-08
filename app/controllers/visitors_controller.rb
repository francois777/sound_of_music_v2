class VersionsController < ApplicationController

  def revert
    @version = PaperTrail::Version.find(params[:id])
    if @version.reify
      @version.reify.save!
    else
      @version.item.destroy
    end
    link_name = params[:redo] == "true" ? "undo" : "redo"
    link = view_context.link_to(link_name, revert_version_path(@version.next, :redo => !params[:redo]), :method => :post)
    redirect_to :back, :success => "Undid #{@version.event}. #{link}"
  end  

  #  Checkout Railscasts #164 about the whenever gem - to delete old versions
  #   uses something like Version.delete_all ["created_at < ?", 1.week.ago] 
  #   in a rake task

end