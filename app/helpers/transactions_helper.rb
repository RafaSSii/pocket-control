module TransactionsHelper

  def category_icon(category)

    case category

    when "Receita"
      "💰"

    when "Despesa"
      "💸"

    else
      "📊"

    end

  end

end