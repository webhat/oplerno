require 'spec_helper'

describe AngelObserver do
  it 'should call before_save on observer' do
    angel = FactoryGirl.create(:angel)

    Angel.observers.enable :angel_observer do
      angel.save
    end
  end
  it 'should call before_save on observer' do
    expect_any_instance_of(described_class).to receive(:before_save)
    angel = FactoryGirl.create(:angel)

    Angel.observers.enable :angel_observer do
      angel.save
    end
  end
  it 'should fetch angellist profile before_save on observer' do
    Mentor.any_instance.stub(:update_avatar)
    mentor = FactoryGirl.create(:mentor)
    angel = mentor.create_angel

    Angel.observers.enable :angel_observer do
      angel.angelslug = ''
      angel.save
    end
  end
  it 'should fetch angellist profile before_save on observer', vcr: {record: :once} do
    Mentor.any_instance.stub(:update_avatar)
    mentor = FactoryGirl.create(:mentor)
    angel = mentor.build_angel angelslug: 'joshuaxls'

    Angel.observers.enable :angel_observer do
      angel.save
    end
    mentor.reload
    expect(mentor.description).to eq 'Venture Hacker @angellist. Previously @super-rewards, acquired by @adknowledge.'
  end
end
