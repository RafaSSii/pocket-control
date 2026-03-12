class TransactionsController < ApplicationController

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to dashboard_path
    else
      redirect_to dashboard_path
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:description, :amount, :category)
  end

end