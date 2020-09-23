class DeliveryDate < ActiveHash::Base
  self.data = [
    { id: 0, name: "--"},
    { id: 1, name: "１〜２日"},
    { id: 2, name: "３〜４日"},
    { id: 3, name: "５〜６日"}
  ] 
end
