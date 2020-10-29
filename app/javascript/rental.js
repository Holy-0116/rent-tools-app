var moment = require("moment");
// 返却日表示関数
const returnDate = () => {
  // イベント発火
  const event = document.querySelectorAll(".event")
  event.forEach((ev) => ev.addEventListener("change",() =>{

    const startDateForm = document.getElementById("order_start_date");
    const orderPeriodForm = document.getElementById("order_period");
    
    if (startDateForm.value !== "" && orderPeriodForm.value !== ""){
      // レンタル開始日取得
      const startDate = new moment(startDateForm.value).format("YYYY/MM/DD");
    
      // レンタル日数取得
      const orderPeriod = orderPeriodForm.value * 7;
    
      // 返却日計算
      let returnDate = new moment();
      returnDate = moment(startDate).add(orderPeriod, 'days').format("YYYY/MM/DD");
      
      // 返却日を表示
      const returnDateForm = document.getElementById("return_date");
      // const returnDateInput = document.getElementById("return_date_input");
      returnDateForm.innerHTML = returnDate;
      price();
    };
  }));
};
// レンタル金額表示関数
const price = () => {
  const rentalPeriod = document.getElementById("order_period");
  const itemPriceForm = document.getElementById("item_price");
  const itemPrice = itemPriceForm.getAttribute("data-item");
  const orderPrice = document.getElementById("order_price");
  const orderPriceInput = document.getElementById("order_price_input");
  const orderPiece = document.getElementById("order_piece");
  // 金額計算
  const totalPrice = rentalPeriod.value * itemPrice * orderPiece.value;
  // 金額表示
  orderPrice.innerHTML = totalPrice;
  orderPriceInput.value = totalPrice;
  

};

if (document.URL.match("/order")){
window.addEventListener('load', returnDate)};



