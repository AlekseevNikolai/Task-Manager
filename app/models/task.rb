class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  validates :name, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :description, length: { maximum: 500 }

  state_machine initial: :new_task do
    state :new_task do
      transition to: :in_development, on: :in_development
      transition to: :archived, on: :archived
    end

    state :in_development do
      transition to: :in_qa, on: :to_qa
    end

    state :in_qa do
      transition to: :in_development, on: :in_development
      transition to: :in_code_review, on: :in_code_review
    end

    state :in_code_review do
      transition to: :ready_for_release, on: :ready_for_release
      transition to: :in_development, on: :in_development
    end

    state :ready_for_release do
      transition to: :released, on: :released
    end

    state :archived
  end
end
