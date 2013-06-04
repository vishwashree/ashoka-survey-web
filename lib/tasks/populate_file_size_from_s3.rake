require 'ruby-progressbar'

namespace :s3 do
  desc "Populates file size for image assets from s3"
  task :cache_file_size => :environment do
    puts "Setting file size for questions"
    questions = Question.unscoped.where("image IS NOT NULL AND photo_file_size IS NULL")
    questions_count = questions.count
    bar = ProgressBar.create(:format => '%a |%b>%i| %p%% %t', :total => questions_count)
    questions.each do |question|
      file = question.image.file
      if file.exists?
        question.update_attribute(:photo_file_size, file.size)
      end
      bar.increment
    end

    puts
    puts "Finished processing #{questions_count} questions."
    puts
    puts "Setting file size for answers"

    answers = Answer.unscoped.where("photo IS NOT NULL AND photo_file_size IS NULL")
    answers_count = answers.count
    bar = ProgressBar.create(:format => '%a |%b>%i| %p%% %t', :total => answers_count)
    answers.each do |answer|
      answer.photo_file_size = answer.photo.file.size
      answer.save
      bar.increment
    end

    puts
    puts "Finished processing #{answers_count} answers."
  end
end