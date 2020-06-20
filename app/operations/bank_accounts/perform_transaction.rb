module BankAccounts
  class PerformTransaction
    def initialize(amount:, transaction_type:, bank_account_id:, account_number_transfer:)
      @amount = amount.try(:to_f)
      @transaction_type = transaction_type
      @bank_account_id = bank_account_id.try(:to_i)
      @bank_account = BankAccount.where(id: @bank_account_id).first
      @tranfer_account = BankAccount.where(account_number: account_number_transfer).first
    end

    def execute!
      ActiveRecord::Base.transaction do
        AccountTransaction.create!(
          bank_account: @bank_account,
          amount: @amount,
          transaction_type: @transaction_type
        )

        if @transaction_type == "wypłata"
          @bank_account.update!(balance: @bank_account.balance - @amount)
        elsif @transaction_type == "wpłata"
          @bank_account.update!(balance: @bank_account.balance + @amount)
        elsif @transaction_type == "przelew"
          AccountTransaction.create!(
            bank_account: @tranfer_account,
            amount: @amount,
            transaction_type: @transaction_type
          )

          @tranfer_account.update!(balance: @tranfer_account.balance + @amount)
          @bank_account.update!(balance: @bank_account.balance - @amount)
        end
      end

      @bank_account
    end
  end
end