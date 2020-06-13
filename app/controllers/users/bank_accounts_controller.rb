module Users
  class BankAccountsController < ApplicationController
    before_action :load_parent_object
    before_action :load_object, only: [:edit, :update, :show]

    def new
      @bank_account = BankAccount.new
    end 

    def create
      @bank_account = BankAccount.new(bank_account_params)
      @bank_account.user = @user

      if @bank_account.save
        redirect_to bank_account_path(@bank_account.id)
      else
        render "new"
      end
    end

    private

    def load_parent_object
      @user = User.find(params[:user_id])
    end

    def load_object
      @bank_account = BankAccount.find(params[:id])
    end

    def bank_account_params
      params.require(:bank_account).permit(:account_number)
    end
  end
end