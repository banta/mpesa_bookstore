class OrderTrnController < ApplicationController
  before_filter :authorize, :except => :login
  def transc
    @transactions = Transaction.find(:all, :order => :created_at)
  end

  def s_transac
    @order = Order.find(params[:id])
  end

  def sms_in
    @ozekimessageins = Ozekimessagein.find(:all, :order => :receivedtime)
  end

  def sms_st
    @ozekimessageouts = Ozekimessageout.find(:all, :order => :senttime)
  end

end