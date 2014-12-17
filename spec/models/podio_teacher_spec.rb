require 'spec_helper'

describe PodioTeacher do
  PodioTeacher.instance_methods(false).each do |hash|
    if hash.to_s.include? '='
      it "##{hash}" do
        podio_teacher = described_class.create!
        expected = "test_#{hash}"
        podio_teacher.send(hash, expected)
        podio_teacher.save
        actual = described_class.find(podio_teacher.id).send(hash.to_s[0..-2].to_sym)
        expect(expected).to eq actual
      end
    end
  end
end
