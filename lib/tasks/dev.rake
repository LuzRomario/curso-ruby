  namespace :dev do
    DEFAULT_PASSWORD = 123456
    
    DEFAULT_FILES_PATH = File.join(Rails.root,'tmp')

    desc "TODO"
      task setup: :environment do
      puts %x(rails db:drop db:create db:migrate db:seed dev:add_default_admin dev:add_default_user dev:add_extra_admins dev:add_subjects dev:add_answers_and_questions)
      end

    desc "Adiciona o admin padrão"
      task add_default_admin: :environment do
      Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
      )
      end

    desc "Adiciona admin extra"
    task add_extra_admins: :environment do
        10.times do |i|
          Admin.create!(
          email: Faker::Internet.email,
          password: DEFAULT_PASSWORD,
          password_confirmation: DEFAULT_PASSWORD
          )
      end
    end

    desc "Adiciona o usuário padrão"
      task add_default_user: :environment do
      User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
      )
      end

    desc "Adiciona assuntos padrão"
      task add_subjects: :environment do
      file_name = 'subjects.txt'
      file_path = File.join(DEFAULT_FILES_PATH, file_name)
      File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
      end
    end

    desc "Adiciona pereguntas e respostas" # Cria de 3 a 6 questões para cada assunto
    task add_answers_and_questions: :environment do
      Subject.all.each do |subject|
        rand(5..10).times do |i|
          params = create_question_params(subject)
          answers_array = params[:question][:answers_attributes]

          rand(2..5).times do |j|
            answers_array.push(
            create_answer_params
            ) 
          end

          elect_true_answer(answers_array)
          

          Question.create!(params[:question])
          end
        end
    end

    private

    def create_question_params(subject)
      params = { question: {
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
        subject: subject,
        answers_attributes: []
      }}
    end

    def create_answer_params(correct = false)
      { description: Faker::Lorem.sentence, correct: correct }
    end

    def elect_true_answer(answers_array = [])
    selected_index = rand(answers_array.size)
      answers_array[selected_index] =  create_answer_params(true)
    end


end