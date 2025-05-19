json.extract! expense, :id, :description, :amount, :date, :currency, :expense_type, :trip_id, :category_id, :payer_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)
