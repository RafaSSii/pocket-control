class DashboardController < ApplicationController

  def index

    @transactions = Transaction.order(created_at: :desc).limit(5)

    @receitas = Transaction.where(category: "Receita").sum(:amount)
    @despesas = Transaction.where(category: "Despesa").sum(:amount)

    @saldo = @receitas - @despesas

    # dados para o gráfico
    @chart_labels = Transaction.group_by_month(:created_at, format: "%b").count.keys
    @chart_receitas = Transaction.where(category: "Receita").group_by_month(:created_at).sum(:amount).values
    @chart_despesas = Transaction.where(category: "Despesa").group_by_month(:created_at).sum(:amount).values

  end

end