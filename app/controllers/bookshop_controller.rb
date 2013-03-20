class BookshopController < ApplicationController
  before_filter :allow_user, :except => :u_login
  #before_filter :initialize_cart
  def index
    @books_categories = BooksCategory.all(:order => "name")
    @books = Book.books_for_sale
    @cart = find_cart
  end

  def bsearch
    @cart = find_cart
    @books = Book.search(params[:search])
  end

  def downl_fmaterials
    @books_categories = BooksCategory.all(:order => "name")
    @free_books = FreeBook.fbooks_for_download
    @cart = find_cart
  end
  def show_dcat
    @cart = find_cart
    @books_category = BooksCategory.find(params[:id])
  end

  def show
    @cart = find_cart
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid book #{params[:id]}")
    flash[:notice] = "Invalid book. Make sure the url is typed correctly."
    redirect_to :action => :index
  end

  def showcat
    @cart = find_cart
    @books_category = BooksCategory.find(params[:id])
  end

  def add_to_cart
    begin
      book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid book #{params[:id]}")
      redirect_to_index("Invalid book")
    else
      @cart = find_cart
      @current_item = @cart.add_book(book)
      if request.xhr?
        respond_to {|format| format.js}
      else
        redirect_to_index(nil)
      end
    end
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index(nil)
  end
  
  def save_order
    @cart = find_cart
    if @cart.items.empty?
      flash[:notice] = "Your cart is empty"
    else
      @order = Order.new
      @ozekimessageout = Ozekimessageout.new
      @transaction = Transaction.new
    end
    #***************************************************************************
    @cart = find_cart
    @order = Order.new(params[:order])
    @order.user_id = session[:user_id]

    @order.add_line_items_from_cart(@cart)

    if @order.save
      @ozekimessageout = Ozekimessageout.new(params[:ozekimessageout])
      @ozekimessageout.order_id = Order.last.id + 1
      @ozekimessageout.sender = "+254713973902"
      @ozekimessageout.receiver = "+#{User.find(session[:user_id]).mpesa_no}"
      $gt = LineItem.sum(:total_price, :conditions => {:order_id => (Order.last.id)})
      @ozekimessageout.msg = "Thank you #{User.find(session[:user_id]).name} for your purchase. Please send KSh.#{$gt} to +254704801935 (mpesa) to complete the trasaction. More info. BantaBookstore.com"
      $tm = Time.now
      @ozekimessageout.receivedtime = $tm
      @ozekimessageout.status = "send"

      if  @ozekimessageout.save
        session[:cart] = nil
        flash[:notice] = "Thank you for your order #{User.find(session[:user_id]).name}. Please send the money through M-Pesa to <b>0704801935</b> once you receive a sms invoive on your phone then click the button below."
      else
        flash[:notice] = "Error. Please try again"
        redirect_to(:controller => :bookshop, :action => index)
      end
    end
  end

  def sms_in
    @transaction = Transaction.new(params[:transaction])
    @cart = find_cart
    $i = 1;
    $num = Ozekimessagein.last.id;
    $uid = User.find(session[:user_id]).id
    until $i > $num  do
      $fr = Ozekimessagein.find($i).sender
      $msg = Ozekimessagein.find($i).msg
      $name = User.find(session[:user_id]).name.upcase
      $m_no = "#{User.find(session[:user_id]).mpesa_no}"

      if $fr == "+254713973902"
        $ksh = $msg.split(" ")[5][3,$msg.split(" ")[5].size].delete(",").to_i #split, 5th element,remove "Ksh", remove ",", change to integer
      else
        $ksh = 0
      end
      if $fr == "+254713973902" and $msg.include?("#{$name}") and $msg.include?("#{$m_no}") and $ksh >= $gt and (Ozekimessagein.find($i).senttime.to_datetime) > (Time.now - 172800)
        @transaction.order_id = Order.last.id
        @transaction.name = User.find(session[:user_id]).name
        @transaction.pnumber = User.find(session[:user_id]).mpesa_no
        @transaction.amount = $gt
        @transaction.status = "Processed"
        if  @transaction.save
          @ozekimessageout = Ozekimessageout.new(params[:ozekimessageout])
          @ozekimessageout.order_id = Order.last.id + 1
          @ozekimessageout.sender = "+254713973902"
          @ozekimessageout.receiver = "+#{User.find(session[:user_id]).mpesa_no}"
          $tw = User.find(session[:user_id]).town
          @ozekimessageout.msg = "Thank you #{User.find(session[:user_id]).name} for your purchase. Your books will be delivered to #{$tw} on #{Time.now + 3.days}. More info. BantaBookstore.com"
          $tm = Time.now
          @ozekimessageout.receivedtime = $tm
          @ozekimessageout.status = "send"
          if  @ozekimessageout.save
            flash[:notice] = "Thank You. You'll receive an sms to notify you when the your books will be delivered"
            $i = $num + 1;
            puts "denis"
          end
        end
      else
        puts "grep"
        if $i == $num 
          @transaction.order_id = Order.last.id
          @transaction.name = User.find(session[:user_id]).name
          @transaction.pnumber = User.find(session[:user_id]).mpesa_no
          @transaction.amount = $gt
          @transaction.status = "Canceled"
          if  @transaction.save
            flash[:notice] = "Transaction canceled"
            @ozekimessageout = Ozekimessageout.new(params[:ozekimessageout])
            @ozekimessageout.order_id = Order.last.id + 1
            @ozekimessageout.sender = "+254713973902"
            @ozekimessageout.receiver = "+#{User.find(session[:user_id]).mpesa_no}"
            @ozekimessageout.msg = "Thank you #{User.find(session[:user_id]).name}. Your transaction has been canceled. Please login to purchase. More info. BantaBookstore.com"
            $tm = Time.now
            @ozekimessageout.receivedtime = $tm
            @ozekimessageout.status = "send"

            if  @ozekimessageout.save
              flash[:notice] = "Your transaction was canceled. You'll receive an sms to notify you."
            end
          end
        end
      end
      $i = $i + 1;
    end
    redirect_to :controller => :home, :action => :index
  end

  def cancel_trans
    @transaction = Transaction.new(params[:transaction])
    @transaction.order_id = Order.last.id
    @transaction.name = User.find(session[:user_id]).name
    @transaction.pnumber = User.find(session[:user_id]).mpesa_no
    @transaction.amount = $gt
    @transaction.status = "Canceled"
    if  @transaction.save
      @ozekimessageout = Ozekimessageout.new(params[:ozekimessageout])
      @ozekimessageout.order_id = Order.last.id + 1
      @ozekimessageout.sender = "+254713973902"
      @ozekimessageout.receiver = "+#{User.find(session[:user_id]).mpesa_no}"
      @ozekimessageout.msg = "Thank you #{User.find(session[:user_id]).name}. Your transaction has been canceled. Please login to purchase. More info. Banta.co.ke/bs"
      $tm = Time.now
      @ozekimessageout.receivedtime = $tm
      @ozekimessageout.status = "send"

      if  @ozekimessageout.save
        flash[:notice] = "Your transaction was canceled. You'll receive an sms to notify you."
        redirect_to :controller => :home, :action => :index
      end
    end
  end

  private
  def counter
    $j = 0;
    $m = 30;

    while $j < $m  do
      sleep(1)
      puts("Inside the loop i = #$j" );
      $j +=1;
    end
  end

  def redirect_to_index(msg)
    flash[:notice] = msg
    redirect_to :action => :index
  end
  def redirect_to_sms(msg)
    flash[:notice] = msg
    redirect_to :action => :sms_in
  end

  def find_cart
    session[:cart] ||= Cart.new
  end
end