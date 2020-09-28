class Category < ActiveHash::Base
  self.data = [
    {id: 0, name: "--"},
    {id: 1, name: "パレットナイフ"},
    {id: 2, name: "セルクル"},
    {id: 3, name: "口金"},
    {id: 4, name: "回転台"},
    {id: 5, name: "抜き型"},
    {id: 6, name: "焼き型"},    
  ]
end
