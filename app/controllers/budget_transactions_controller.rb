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
    group = current_user.groups.find(params[:group_id])
    transaction = group.budget_transactions.create(**transaction_params, author: current_user)
    respond_to do |format|
      format.html do
        if transaction.id
          redirect_to group_budget_transactions_path(group.id), notice: 'Transaction added!'
        else
          redirect_to new_group_budget_transaction_path(group.id), alert: 'Please, fill all fields'
        end
      end
    end
  end

  private

  def transaction_params
    params.require(:budget_transaction).permit(:name, :amount)
  end
end
