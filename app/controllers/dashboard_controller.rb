class DashboardController < ApplicationController
  before_action :require_login

  def index

    # últimas transações
    @transactions = current_user.transactions.order(created_at: :desc).limit(10)

    # totais
    @receitas = current_user.transactions.where(category: "Receita").sum(:amount)
    @despesas = current_user.transactions.where(category: "Despesa").sum(:amount)

    @saldo = @receitas - @despesas


    # DADOS DO GRÁFICO (últimos 6 meses)

    meses = (0..5).map { |i| i.months.ago.beginning_of_month }.reverse

    @chart_labels = meses.map { |m| m.strftime("%b") }

    @chart_receitas = meses.map do |mes|
      current_user.transactions
                  .where(category: "Receita")
                  .where(created_at: mes..mes.end_of_month)
                  .sum(:amount)
    end

    @chart_despesas = meses.map do |mes|
      current_user.transactions
                  .where(category: "Despesa")
                  .where(created_at: mes..mes.end_of_month)
                  .sum(:amount)
    end

  end


  private

  def require_login
    redirect_to login_path unless session[:user_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  helper_method :current_user

end