class UserValidator < ActiveModel::Validator
  def validate(record)
    begin
      unless record.links.nil?
        record.links.each do |i, link|
          validate_link(i, record, link)
        end
      end
    rescue
      #     record.links = []
    end
  end

  private

  def validate_link(i, record, link)
    if link['name'].empty?
      return if link['url'].empty? 
      record.errors[:links] << I18n.t('users.fail.no_description')
    end
  end
end

