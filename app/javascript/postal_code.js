function initPostcodeJp() {
  
  // APIキーを指定して住所補完サービスを作成
  const key = process.env.POSTAL_CODE_JP_KEY
  var postcodeJp = new postcodejp.address.AutoComplementService(key);
  
  // 郵便番号テキストボックスを指定
  postcodeJp.setZipTextbox('address_postal_code')

  // 住所補完フィールドを追加
  postcodeJp.add(new postcodejp.address.StateSelectbox('address_prefecture_id'));
  postcodeJp.add(new postcodejp.address.TownStreetTextbox('address_city_name'));

  // 郵便番号テキストボックスの監視を開始
  postcodeJp.observe();

}

if(window.addEventListener){
  window.addEventListener('load', initPostcodeJp)
}else{
  window.attachEvent('onload', initPostcodeJp)
}