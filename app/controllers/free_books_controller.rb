class FreeBooksController < ApplicationController
  before_filter :allow_user, :except => [:login]
  #before_filter :authorize, :except => [:new, :create]
  
  #before_filter :allow_user, :except => :new and :create
  layout"application"
  # GET /free_books
  # GET /free_books.xml
  def index
    @free_books = FreeBook.all(:order => "title")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @free_books }
    end
  end

  # GET /free_books/1
  # GET /free_books/1.xml
  def show
    @free_book = FreeBook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @free_book }
    end
  end

  # GET /free_books/new
  # GET /free_books/new.xml
  def new
    @free_book = FreeBook.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @free_book }
    end
  end

  # GET /free_books/1/edit
  def edit
    @free_book = FreeBook.find(params[:id])
  end

  # POST /free_books
  # POST /free_books.xml
  def create
    @free_book = FreeBook.new(params[:free_book])

    pic = params[:free_book][:picture]
    @free_book.picture = pic.original_filename
    FileUtils.copy(pic.local_path, "#{RAILS_ROOT}/public/fbooks_pics/#{pic.original_filename}")

    book_st = params[:free_book][:book_url]
    @free_book.book_url = book_st.original_filename
    FileUtils.copy(book_st.local_path, "#{RAILS_ROOT}/public/fbooks_st/#{book_st.original_filename}")

    respond_to do |format|
      if @free_book.save
        format.html { redirect_to(@free_book, :notice => 'FreeBook was successfully created.') }
        format.xml  { render :xml => @free_book, :status => :created, :location => @free_book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @free_book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /free_books/1
  # PUT /free_books/1.xml
  def update
    @free_book = FreeBook.find(params[:id])

    respond_to do |format|
      if @free_book.update_attributes(params[:free_book])
        format.html { redirect_to(@free_book, :notice => 'FreeBook was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @free_book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /free_books/1
  # DELETE /free_books/1.xml
  def destroy
    @free_book = FreeBook.find(params[:id])
    File.delete("#{RAILS_ROOT}/public/fbooks_pics/#{@free_book.picture}")
    File.delete("#{RAILS_ROOT}/public/fbooks_st/#{@free_book.book_url}")
    @free_book.destroy

    respond_to do |format|
      format.html { redirect_to(free_books_url) }
      format.xml  { head :ok }
    end
  end
end
