require 'rails_helper'
# As an unauthenticated user, when I visit /,
# I should be redirected to a page which prompts me to "Log In or Sign Up".
# As an unauthenticated user, if I click "Sign Up", I should be taken to a form where I can enter an email address, a password, and a password confirmation.
#
#     I cannot sign up with an email address that has already been used.
#     I cannot sign up without an email address and a password.
#     Password and confirmation must match.
#     If criteria is not met the user should be given a message to reflect the reason they could not sign up.
#
# Upon submitting this information, I should be logged in and redirected to the "Links Index" page.
describe "user account creation" do
  it "requires an email and password" do
    visit root_path
    expect(current_path).to eq(authenticate_path)
    click_on 'Sign Up'
    save_and_open_page
    expect(current_path).to eq(new_user_path)

    fill_in('user[email]', with: 'email@email.com')
    fill_in('user[password]', with: 'password')
    fill_in('user[password_confirmation]', with: 'password')

    click_on 'Sign Up'

    expect(current_path).to eq(root_path)
  end
end
