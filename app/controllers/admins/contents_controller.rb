class Admins::ContentsController < Admins::ApplicationController
  before_filter :find_content, :except => :index

  # index
  def index
    @contents = Content.all
  end

  # detail page
  def show
  end

  # edit
  def edit
  end

  # update
  def update
    if @content.update_attributes(params[:content])
      flash[:notice] = "#{@content.title} is updated"
      redirect_to admins_content_url(@content.code)
    else
      flash[:alert] = "Update content failed"
      render action: edit
    end
  end

  protected

    # find content
    def find_content
      @content = Content.find_by_code(params[:id] || params[:code])
    end
end
