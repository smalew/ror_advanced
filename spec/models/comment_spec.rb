# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  user_id          :bigint
#  commentable_type :string
#  commentable_id   :bigint
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:commentable) }

    it { should have_db_column(:commentable_id) }
    it { should have_db_column(:user_id) }
  end

  context 'validations' do
    it { should validate_presence_of(:body) }
  end
end
