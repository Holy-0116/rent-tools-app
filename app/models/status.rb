class Status < ActiveHash::Base
  self.data = [
    { id: 1, name: "新品"},
    { id: 2, name: "やや傷あり"},
  ]

end

