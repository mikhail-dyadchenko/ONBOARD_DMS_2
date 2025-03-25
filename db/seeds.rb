

@raw_text = 'Дом Наркомфина — один из знаковых памятников архитектуры советского авангарда и конструктивизма. Построен в 1928—1930 годах по проекту архитекторов Моисея Гинзбурга, Игнатия Милиниса и инженера Сергея Прохорова для работников Народного комиссариата финансов СССР (Наркомфина). Автор замысла дома Наркомфина Гинзбург определял его как «опытный дом переходного типа». Дом находится в Москве по адресу: Новинский бульвар, дом 25, корпус 1. С начала 1990-х годов дом находился в аварийном состоянии, был трижды включён в список «100 главных зданий мира, которым грозит уничтожение». В 2017—2020 годах отреставрирован по проекту АБ «Гинзбург Архитектс», функционирует как элитный жилой дом. Отдельно стоящий «Коммунальный блок» (историческое название) планируется как место проведения публичных мероприятий.'
@words = @raw_text.downcase.gsub(/[—.—,«»:()]/, '').gsub(/  /, ' ').split(' ')

def seed
  reset_db
  create_users(20)
  create_cards(100)
  create_comments(2..8)
end

def create_users(quantity)
  i = 0

  quantity.times do
    user_data = {
      email: "user_#{i}@email.com",
      password: 'testtest'
    }

    user = User.create!(user_data)
    puts "User created with id #{user.id}"

    i += 1
  end
end

def reset_db
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
end

def create_sentence
  sentence_words = []

  (10..20).to_a.sample.times do
    sentence_words << @words.sample
  end

  sentence = sentence_words.join(' ').capitalize + '.'
end

def upload_random_image
  uploader = ImgUploader.new(Card.new, :img)
  uploader.cache!(File.open(Dir.glob(File.join(Rails.root, 'public/autoupload/cards', '*')).sample))
  uploader
end

def create_cards(quantity)
  quantity.times do |user|
    user = User.all.sample
    card = Card.create(title: create_sentence, description: create_sentence, img: upload_random_image, user: user)
    puts "Card with id #{card.id} just created"
  end
end

def create_comments(quantity)
Card.all.each do |card|
    quantity.to_a.sample.times do
      user = User.all.sample
      comment = Comment.create(card_id: card.id, body: create_sentence, user: user)
      puts "Comment with id #{comment.id} for card with id #{card.id} just created"
    end
  end
end

seed
