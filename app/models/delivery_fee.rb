class DeliveryFee < ActiveHash::Base
  self.data = [
    { id: 1, name: "店舗負担"},
    { id: 2, name: "利用者負担"}
  ] 
end
