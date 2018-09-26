module ApplicationHelper

  def journals_awaiting_approval
    @_journals_awaiting_approval ||= Journal.unapproved.count
  end

  def display_journal_approval_link

  end
end
