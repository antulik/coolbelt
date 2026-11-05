module Coolbelt::Controller::ActionNames
  extend ActiveSupport::Concern

  def new? = action_name.new? || action_name.create?
  def edit? = action_name.edit? || action_name.update?
  def destroy? = action_name.destroy?
  def show? = action_name.show?
  def crud? = new? || id?
  def id? = params[:id].present?
  def index? = !crud?

  def action_name
    super.inquiry
  end
end
