module BankAccounts
  class ValidateNewTransaction
    def initialize(amount:, transaction_type:, bank_account_id:)
      @amount = amount.try(:to_f)
      @transaction_type = transaction_type
      @bank_account_id = bank_account_id.try(:to_i)
      @bank_account = BankAccount.where(id: @bank_account_id).first
      @errors = []
    end

    def execute!
      validate_existence_of_account!

      if @transaction_type == "wypłata" or @transaction_type == "przelew" and @bank_account.present?
        validate_withdrawal!
      end

      @errors
    end

    private

    def validate_withdrawal!
      if @bank_account.balance - @amount < 0.00
        @errors << "Nie masz wystarczająco pieniędzy"
      end
    end

    def validate_existence_of_account!
      if @bank_account.nil?
        @errors << "Nie znaleziono konta"
      end
    end
  end
end