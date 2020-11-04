class Category < ActiveHash::Base
  self.data = [
    {id: 0, name: "パレットナイフ"},
    {id: 1, name: "セルクル"},
    {id: 2, name: "口金"},
    {id: 3, name: "回転台"},
    {id: 4, name: "抜き型"},
    {id: 5, name: "焼き型"},    
  ]
end
