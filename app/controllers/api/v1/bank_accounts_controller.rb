module Api
  module V1
    class BankAccountsController < ApplicationController
      def new_transaction
        amount = params[:amount]
        transaction_type = params[:transactionType]
        bank_account_id = params[:bankAccountId]
        account_number_transfer = params[:accountNumberTransfer]
        
        errors = ::BankAccounts::ValidateNewTransaction.new(
                   amount: amount,
                   transaction_type: transaction_type,
                   bank_account_id: bank_account_id
                  ).execute!
                  
        if errors.count > 0
          render json: { errors: errors }, status: 402
        else
          bank_account = ::BankAccounts::PerformTransaction.new(
                          amount: amount,
                          transaction_type: transaction_type,
                          bank_account_id: bank_account_id,
                          account_number_transfer: account_number_transfer
                          ).execute!
          
          render json: { balance: bank_account.balance }
        end
      end
    end
  end
end