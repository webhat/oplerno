class Setting < ActiveRecord::Base
  attr_accessible :key, :value

  has_paper_trail
  acts_as_paranoid

  alias_attribute :display_name, :key

  def self.get_key key, default = nil
    setting = self.find_by_key(key)
    unless setting.nil?
      setting
    else
      s = OpenStruct.new
      s.key = key
      s.value = default
      s
    end
  end
end
