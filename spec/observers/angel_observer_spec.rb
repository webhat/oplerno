require 'spec_helper'

describe AngelObserver do
  it 'should call after_save on observer' do
    described_class.instance.should_receive(:after_save)
    angel = FactoryGirl.create(:angel)

    Angel.observers.enable :angel_observer do
      angel.save
    end
  end
  it 'should call after_save on observer' do
    described_class.any_instance.should_receive(:after_save).once
    angel = FactoryGirl.create(:angel)

    Angel.observers.enable :angel_observer do
      angel.save
    end
  end
  it 'should fetch angellist profile after_save on observer', vcr: {record: :once} do
    Mentor.any_instance.stub(:update_avatar)
    mentor = FactoryGirl.create(:mentor)
    angel = mentor.build_angel angelslug: 'joshuaxls'

    Angel.observers.enable :angel_observer do
      angel.save
    end
    mentor.reload
    expect(mentor.description).to eq 'Test'
  end
end
