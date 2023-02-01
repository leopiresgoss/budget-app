class BudgetTransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @group = current_user.groups.find(params[:group_id])
    @transactions = @group.budget_transactions.order(created_at: :desc)
  end

  def new
    @group = current_user.groups.find(params[:group_id])
  end

  def create
    transaction = BudgetTransaction.new(**budget_transaction_params, author: current_user)

    respond_to do |format|
      format.html do
        if transaction.save
          id = transaction.groups.first.id
          redirect_to group_budget_transactions_path(id), notice: 'Transaction added!'
        else
          redirect_to new_group_budget_transaction_path(params[:group_id]),
                      alert: transaction.errors.full_messages.join(', ')
        end
      end
    end
  end

  private

  def budget_transaction_params
    params.require(:budget_transaction).permit(:name, :amount, group_ids: [])
  end
end
