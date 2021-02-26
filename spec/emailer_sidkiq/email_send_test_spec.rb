RSpec.describe 'Test sending email with sidekiq', type: :request do
  it 'send email to sidekiq' do
    user = User.create(name: 'Brett Sherman', email: 'bjsherman80@gmail.com')

    expect do
        binding.pry
      UsersMailer.welcome_email(user.id).deliver_later
    end.to change(Sidekiq::Worker.jobs, :size).by(1)
  end
end
