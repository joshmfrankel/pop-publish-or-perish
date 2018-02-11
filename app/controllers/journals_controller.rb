class JournalsController < ApplicationController
  before_action :require_login

  def index
    @journals = Journal.all
  end
end
