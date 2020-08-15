class Year < ActiveHash::Base
  self.data = [
    {id: 1, name: '20'}, {id: 2, name: '21'}, {id: 3, name: '22'},
    {id: 4, name: '23'}, {id: 5, name: '24'}, {id: 6, name: '25'},
    {id: 7, name: '26'}, {id: 8, name: '27'}, {id: 9, name: '28'},
    {id: 10, name: '29'}, {id: 11, name: '30'}, {id: 12, name: '31'},
    {id: 13, name: '32'}, {id: 14, name: '33'}, {id: 15, name: '34'},
  ]

  include ActiveHash::Associations
  has_many :cards
end
