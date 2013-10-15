# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

teams = Team.create([
    {name: 'Mikamayhem', colour: 'green', order: 1},
    {name: 'TIMEREPUBLIK', colour: 'yellow', order: 2},
    {name: 'call_me_maybe', colour: 'orange', order: 3},
    {name: 'PaduaNinja', colour: 'cyan', order: 4},
    {name: 'Rubysconi', colour: 'red', order: 5},
    {name: 'SpazzaRubini', colour: 'nightblue', order: 6},
    {name: 'Antani', colour: 'brown', order: 7},
    {name: 'Ippongi', colour: 'purple', order: 8}
  ])


ninjas = Ninja.create([
    {name: 'Nicola Racco', twitter: 'nicolaracco', team_id: '1'},
    {name: 'Ivan Prignano', twitter: 'iprignano', team_id: '1'},

    {name: 'Davide Barison', twitter: 'davidebarison', facebook: '', team_id: '2'},
    {name: 'Stefano Ceschi Berrini', twitter: 'stecb', team_id: '2'},
    {name: 'Enrico Pilotto', twitter: 'pioz', team_id: '2'},
    {name: 'Andrea Zaupa', twitter: 'azaupa', team_id: '2'},

    {name: 'Michele Franzin', twitter: 'realfuzzy', team_id: '3'},
    {name: 'Andrea Pigato', twitter: 'pigatss', team_id: '3'},
    {name: 'Andrea Briguglio', twitter: 'BriguGraphic', team_id: '3'},
    {name: 'Luca', twitter: 'Ortostasi', team_id: '3'},

    {name: 'Diego Giorgini', twitter: 'ogeidix', team_id: '4'},
    {name: 'Matteo Scapin', twitter: 'MatteoScapin', team_id: '4'},
    {name: 'Tommaso Grotto', twitter: 'tommasogrotto', team_id: '4'},

    {name: 'Michele Gobbi', twitter: 'dynamick', team_id: '5'},
    {name: 'Luciano Melotti', facebook: 'luciano.melotti', team_id: '5'},
    {name: 'Nicola Galdiolo', facebook: 'nicolagurugaldiolo', team_id: '5'},
    {name: 'Marco Pozzato', facebook: 'marco.pozzato', team_id: '5'},

    {name: 'Ignazio Setti', facebook: '100004615651459', team_id: '6'},
    {name: 'Duilio Ruggiero', twitter: 'sinetris', team_id: '6'},
    {name: 'Marius Colacioiu', twitter: 'colmarius', team_id: '6'},

    {name: 'Marcello Barnaba', twitter: 'vjt', team_id: '7'},
    {name: 'Vincenzo Acinapura', facebook: 'vincenzo.acinapura', team_id: '7'},
    {name: 'Giuseppe Burdo', twitter: 'giuseppeburdo', team_id: '7'},

    {name: 'Stefano Franzin', twitter: 'sfranzolo', team_id: '8'},
    {name: 'Andrea Collet', twitter: 'ifthenelse', team_id: '8'},
    {name: 'Riccardo Gueli Alletti', twitter: 'riccardo_ga', team_id: '8'}

  ])