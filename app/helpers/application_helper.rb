module ApplicationHelper

  def balance_of_user
    number_to_currency(BankAccount.where(id: current_user.id).last.balance, :unit => "")
  end

  def transactions_count
    AccountTransaction.where(bank_account_id: current_user.id).count
  end

  def last_transaction
    if AccountTransaction.where(bank_account_id: current_user.id).count > 1
      number_to_currency(AccountTransaction.where(bank_account_id: current_user.id).last.amount, :unit => "")
    else
      "0.00"
    end
  end

  def user_sign_in_count
    User.where(id: current_user.id).last.sign_in_count
  end

end
