class DashboardController < ApplicationController
  def index

    @transactions = Transaction.all

    # Totais
    @receitas = @transactions.where(category: "Receita").sum(:amount)
    @despesas = @transactions.where(category: "Despesa").sum(:amount)

    @saldo = @receitas - @despesas



    receitas_por_dia = @transactions
                         .where(category: "Receita")
                         .group("DATE(created_at)")
                         .sum(:amount)

    despesas_por_dia = @transactions
                         .where(category: "Despesa")
                         .group("DATE(created_at)")
                         .sum(:amount)

    datas = (receitas_por_dia.keys + despesas_por_dia.keys).uniq.sort

    @chart_labels = datas.map { |d| d.strftime("%d/%m") }

    @chart_receitas = datas.map { |d| receitas_por_dia[d] || 0 }

    @chart_despesas = datas.map { |d| despesas_por_dia[d] || 0 }



    categorias = @transactions.group(:category).sum(:amount)

    @pizza_labels = categorias.keys
    @pizza_values = categorias.values

  end
end