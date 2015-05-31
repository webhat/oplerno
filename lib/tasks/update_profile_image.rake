namespace :update do
  namespace :profile do
    task :image => :environment do
      str_io_max =  OpenURI::Buffer.const_get 'StringMax'
      OpenURI::Buffer.const_set 'StringMax', 4096000
      Teacher.all.each do |teacher|
        if teacher.avatar_file_name.nil?
          p "#{teacher.id} - #{ teacher.display_name }"
          p 'X'
          unless teacher.podio_teacher.nil?
            p "#{teacher.id} - #{ teacher.display_name }"
            begin
              teacher.avatar = open("http://gravatar.com/avatar/#{Digest::MD5.hexdigest teacher.podio_teacher.email}.png?s=400&d=404")
              teacher.save
            rescue
              p 'Skipped' 
            end
          end
        end
      end
      OpenURI::Buffer.const_set 'StringMax', str_io_max
    end
  end
end
