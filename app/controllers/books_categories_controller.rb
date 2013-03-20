class BooksCategoriesController < ApplicationController
  before_filter :authorize, :except => :u_login
  layout"application"
  # GET /books_categories
  # GET /books_categories.xml
  def index
    @books_categories = BooksCategory.all(:order => "name")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books_categories }
    end
  end

  # GET /books_categories/1
  # GET /books_categories/1.xml
  def show
    @books_category = BooksCategory.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid book_category #{params[:id]}")
    flash[:notice] = "Invalid category. Make sure the url is typed correctly."
    redirect_to :action => :index
  else
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @books_category }
    end
  end

  # GET /books_categories/new
  # GET /books_categories/new.xml
  def new
    @books_category = BooksCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @books_category }
    end
  end

  # GET /books_categories/1/edit
  def edit
    @books_category = BooksCategory.find(params[:id])
  end

  # POST /books_categories
  # POST /books_categories.xml
  def create
    @books_category = BooksCategory.new(params[:books_category])

    respond_to do |format|
      if @books_category.save
        format.html { redirect_to(@books_category, :notice => 'BooksCategory was successfully created.') }
        format.xml  { render :xml => @books_category, :status => :created, :location => @books_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @books_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books_categories/1
  # PUT /books_categories/1.xml
  def update
    @books_category = BooksCategory.find(params[:id])

    respond_to do |format|
      if @books_category.update_attributes(params[:books_category])
        format.html { redirect_to(@books_category, :notice => 'BooksCategory was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @books_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books_categories/1
  # DELETE /books_categories/1.xml
  def destroy
    @books_category = BooksCategory.find(params[:id])
    @books_category.destroy

    respond_to do |format|
      format.html { redirect_to(books_categories_url) }
      format.xml  { head :ok }
    end
  end
end