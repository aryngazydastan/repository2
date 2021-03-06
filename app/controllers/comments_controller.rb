class CommentsController < ApplicationController
  respond_to :html, :xml, :json
  respond_to :js, :only => [:create, :update, :destroy]
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
    #respond_with(@comment, :layout => false)
    respond_with do |format|
      format.html { render :layout => ! request.xhr? }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.create(comment_params)
    if request.xhr? || remotipart_submitted?
      sleep 1 if params[:pause]
      render :layout => false, :template => (params[:template] == 'escape' ? 'comments/escape_test' : 'comments/create'), :status => (@comment.errors.any? ? :unprocessable_entity : :ok)
    else
      redirect_to comments_path
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])
    respond_with do |format|
      format.html{ redirect_to @comment }
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.destroy(params[:id])
  end

  # GET /books/search
  # GET /books/search.xml
  def search
    @comments = Comment.search do
      keywords params[:query]
    end.results

    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @comments }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:subject, :body, :attachment)
  end
end
