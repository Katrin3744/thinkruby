class RailwayRoad
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def menu
    number = 1
    while number != 0
      puts "1. Создать станцию, поезд" #
      puts "2. Создать маршрут, добавить или удалить станцию из маршрута" #
      puts "3. Добавить или отцепить вагоны от поезда" #
      puts "4. Назначить поезду маршрут" #
      puts "5. Переместить поезд по маршруту вперед или назад"
      puts "6. Просмотреть список станций" #
      puts "7. Просмотреть список поездов на станции" #
      puts "0. Выход из программы" #
      number = gets.chomp.to_i
      case number
      when 1
        creating_station_or_train
      when 2
        creating_changing_route
      when 3
        rc_of_train
      when 4
        route_to_train
      when 5
        motion_train
      when 6
        show(@stations)
      when 7
        show_station_trains
      else
        puts "Попробуйте выбрыть еще раз"
      end
    end
  end


  private # все последующие методы не должны быть доступны пользователю, так как вызываются отдельно в меню при выборе команды

  def creating_station_or_train
    puts "1. Создать станцию"
    puts "2. Создать поезд"
    number = gets.chomp.to_i
    puts "Введите название"
    name = gets.chomp
    case number
    when 1
      @stations.push(Station.new(name))
    when 2
      puts "Какой поезд вы хотите создать: 1. Грузовой 2.Пассажирский"
      num_tr = gets.chomp.to_i
      case num_tr
      when 1
        @trains.push(CargoTrain.new(name))
      when 2
        @trains.push(PassengerTrain.new(name))
      end
    end
  end

  def show(something)
    i = 0
    puts "Список:"
    something.each do |one_of|
      i += 1
      puts "#{i} #{one_of}"
    end
  end

  def show_station_trains
    puts "Выберите станцию"
    show(@stations)
    st_num1 = gets.chomp.to_i
    puts "Список поездов:"
    @stations[st_num1 - 1].trains.each { |train| puts train }
  end

  def creating_changing_route
    puts "1. Создать маршрут"
    puts "2. Добавить к существующему маршруту станцию"
    puts "3. Удалить у существующего маршрута станцию"
    number = gets.chomp.to_i
    case number
    when 1
      puts "Выберите номера двух станции: начальную и конечную для маршрута"
      show(@stations)
      st_num1 = gets.chomp.to_i
      st_num2 = gets.chomp.to_i
      @routes.push(Route.new(@stations[st_num1 - 1], @stations[st_num2 - 1]))
    when 2
      puts "Выберите маршрут"
      show(@routes)
      route_num = gets.chomp.to_i
      st_route = @stations.select { |st| !@routes[route_num - 1].stations.include?(st) }
      if st_route.any?
        puts "Выберите станцию"
        show(st_route)
        st_num1 = gets.chomp.to_i
        @routes[route_num - 1].add_station(st_route[st_num1 - 1])
      else
        "Все станции уже включены в данный маршрут"
      end
    when 3
      puts "Выберите маршрут"
      show(@routes)
      route_num = gets.chomp.to_i
      puts "Выберите станцию"
      show(@routes[route_num - 1].stations)
      st_num1 = gets.chomp.to_i
      tr = @trains.select { |train| train.route == @routes[route_num - 1].stations and train.current_station == @routes[route_num - 1].stations[st_num1 - 1] }
      if tr.any?
        tr.each { |train| @routes[route_num - 1].stations[st_num1 - 1].departure_train(train) }
        tr.each do |train|
          if !train.transition_forward
            train.transition_back # крайний случай, когда удалили все станции маршрута поезда не обрабатывается
          end
          st2 = @stations.find { |station| station == train.current_station }
          st2.add_train(train) if st2
        end
      end
      @routes[route_num - 1].delete_station(@routes[route_num - 1].stations[st_num1 - 1]) # необходимо переместить поезд с удаленной станции в маршруте

    end
  end

  def route_to_train
    tr = @trains.select { |train| !train.route.any? }
    if tr.any?
      puts "Выберите поезд"
      show(tr)
      tr_num = gets.chomp.to_i
      puts "Выберите маршрут"
      show(@routes)
      route_num = gets.chomp.to_i
      tr[tr_num - 1].train_route_add(@routes[route_num - 1])
      @routes[route_num - 1].stations.first.add_train(tr[tr_num - 1])
    else
      puts "Всем поездам назанчены маршруты"
    end
  end

  def rc_of_train
    puts "Выберите поезд"
    show(@trains)
    tr_num = gets.chomp.to_i
    puts "Выберите дейтсвие: 1. Добавить вагон 2.Удалить вагон"
    number = gets.chomp.to_i
    case number
    when 1
      add_rc_to_train(tr_num)
    when 2
      remove_rc_from_train(tr_num) if @trains[tr_num - 1].railway_carriage.any?
    end
  end

  def add_rc_to_train(tr_num)
    puts "Введите номер вагона"
    idx = gets.chomp.to_i
    case @trains[tr_num - 1].class.name
    when "PassengerTrain"
      @trains[tr_num - 1].hook_up(PassengerRC.new(idx))
    when "CargoTrain"
      @trains[tr_num - 1].hook_up(CargoRC.new(idx))
    end
  end

  def remove_rc_from_train(tr_num)
    puts "Введите номер вагона"
    show(@trains[tr_num - 1].railway_carriage)
    idx = gets.chomp.to_i
    case @trains[tr_num - 1].class.name
    when "PassengerTrain"
      @trains[tr_num - 1].unhook(@trains[tr_num - 1].railway_carriage[idx])
    when "CargoTrain"
      @trains[tr_num - 1].unhook(@trains[tr_num - 1].railway_carriage[idx])
    end
  end

  def motion_train
    puts "Выберите поезд"
    show(@trains)
    tr_num = gets.chomp.to_i
    puts "Выберите дейтсвие: 1. Переместить вперед 2.Переместить назад"
    number = gets.chomp.to_i
    puts @trains[tr_num - 1].route
    st = @stations.find { |station| station == @trains[tr_num - 1].current_station }
    st.departure_train(@trains[tr_num - 1]) if st
    case number
    when 1
      @trains[tr_num - 1].transition_forward
    when 2
      @trains[tr_num - 1].transition_back
    end
    st2 = @stations.find { |station| station == @trains[tr_num - 1].current_station }
    st2.add_train(@trains[tr_num - 1]) if st2 and !st2.trains.include?(@trains[tr_num - 1])
  end

end