class Category < ActiveHash::Base
  self.data = [
    {id: 1, name: "--"},
    {id: 2, name: "パレットナイフ"},
    {id: 3, name: "セルクル"},
    {id: 4, name: "口金"},
    {id: 5, name: "回転台"},
    {id: 6, name: "抜き型"},
    {id: 7, name: "焼き型"},    
  ]
end
