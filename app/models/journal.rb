class Journal < ApplicationRecord
  include Approvable

  belongs_to :approver, class_name: "Academic", required: false
end
