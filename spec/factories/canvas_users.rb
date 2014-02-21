# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :canvas_user, :class => 'CanvasUsers' do
    user nil
    avatar_url 'http://www.gravatar.com/avatar/4eacee3eac6699a3050af074bc5d90ed.png'
    canvas_id '2'
    locale 'en_US'
    username 'webhat'
  end
end
