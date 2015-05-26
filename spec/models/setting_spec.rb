require 'spec_helper'

describe Setting do
  context '' do
    before do
      @setting = described_class.create! key: 'key', value: 'value'
    end
    it '#get_key' do
      expect(described_class.get_key(@setting.key).value).to eq @setting.value
    end
    it '#get_key default: 50' do
      expect(described_class.get_key(@setting.key, 50).value).to eq @setting.value
    end
    it '#get_key nil' do
      setting = described_class.get_key('nothing')
      expect(setting.value).to_not eq @setting.value
      expect(setting.value).to eq nil
    end
    it '#get_key nil, default: 50' do
      setting = described_class.get_key('nothing')
      expect(setting.value).to_not eq @setting.value
      expect(setting.value).to eq nil
    end
  end
end
