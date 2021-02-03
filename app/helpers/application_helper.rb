module ApplicationHelper

  def journals_awaiting_approval
    @_journals_awaiting_approval ||= Journal.unapproved.count
  end


end
