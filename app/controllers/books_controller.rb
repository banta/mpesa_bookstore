class BooksController < ApplicationController
  before_filter :authorize, :except => :login
  layout"application"
  # GET /books
  # GET /books.xml
  def index
    @books = Book.all(:order => "name")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
    end
  end

  def search
    @books = Book.search(params[:search])
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    begin
      @book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid book #{params[:id]}")
      flash[:notice] = "Invalid book. Make sure the url is typed correctly."
      redirect_to :action => :index
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @book }
      end
    end
  end


  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])

    pic = params[:book][:picture]

    @book.picture = pic.original_filename

    FileUtils.copy(pic.local_path, "#{RAILS_ROOT}/public/books_pics/#{pic.original_filename}")

    respond_to do |format|
      if @book.save
        flash[:notice] = 'Book was successfully created.'
        format.html { redirect_to(@book, :notice => 'Book was successfully created.') }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Book was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    File.delete("RAILS_ROOT}/public/books_pics//#{@book.picture}")
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :cancel }
    end
  end
end
