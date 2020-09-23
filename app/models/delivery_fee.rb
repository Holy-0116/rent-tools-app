class DeliveryFee < ActiveHash::Base
  self.data = [
    { id: 0, name: "--"},
    { id: 1, name: "全額店舗負担"},
    { id: 2, name: "発送者負担"},
    { id: 3, name: "全額利用者負担"}
  ] 
end
