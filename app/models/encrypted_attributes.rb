# Creates Encrypted Attributes
module EncryptedAttributes
  def create_encrypted_attributes (*args)
    args.each do |method_name|
      define_method "encrypted_#{method_name}" do
        self.send(method_name).decrypt Devise.secret_key
      end
      define_method "encrypted_#{method_name}=" do |input|
        self.send("#{method_name}=", input)
      end
    end
  end
end
