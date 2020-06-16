module ApplicationHelper

  def balance_of_user
    BankAccount.where(id: current_user.id).last.balance
  end

  def transactions_count
    AccountTransaction.where(bank_account_id: current_user.id).count
  end

  def transaction_exist?
    AccountTransaction.where(bank_account_id: current_user.id).count > 0
  end

  def last_transaction
    if transaction_exist?
      AccountTransaction.where(bank_account_id: current_user.id).last.amount
    else
      0.00
    end
  end

  def last_5_transactions
    AccountTransaction.where(bank_account_id: current_user.id).last(5)
  end

  def user_sign_in_count
    User.where(id: current_user.id).last.sign_in_count
  end

  def currency(amount)
    number_to_currency(amount, unit: " zł", 
                               separator: ",", 
                               delimiter: "", 
                               format: "%n %u")
  end

end
