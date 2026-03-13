class TransactionsController < ApplicationController

  before_action :set_transaction, only: [:edit, :update, :destroy]

  def create
    @transaction = current_user.transactions.new(transaction_params)

    if @transaction.save
      redirect_to dashboard_path
    else
      redirect_to dashboard_path
    end
  end


  def edit
  end


  def update
    if @transaction.update(transaction_params)
      redirect_to dashboard_path
    else
      redirect_to dashboard_path
    end
  end


  def destroy
    @transaction.destroy
    redirect_to dashboard_path
  end


  private

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end


  def transaction_params
    params.require(:transaction).permit(:description, :amount, :category)
  end


  def current_user
    @current_user ||= User.find(session[:user_id])
  end

end