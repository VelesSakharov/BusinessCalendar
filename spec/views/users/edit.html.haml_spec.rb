# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
                            name: '',
                            content: ''
    ))
  end

  it 'renders the edit user form' do
    render

    assert_select 'form[action=?][method=?]', user_path(@user), 'post' do
      assert_select 'input#user_name[name=?]', 'user[name]'

      assert_select 'input#user_content[name=?]', 'user[content]'
    end
  end
end
