const period = () => {
  // レンタル期間表示
  const event = document.querySelectorAll(".event")
  event.forEach((ev) => ev.addEventListener("change",() =>{
    const startDateForm =document.getElementById("order_start_date");
    const returnDateForm = document.getElementById("return_date");

    const startDate = new Date(startDateForm.value)
    const returnDate = new Date(returnDateForm.value)
    const periodDate = returnDate.getDate() - startDate.getDate();
    
    const orderPeriod = document.getElementById("order_period");
    orderPeriod.value = periodDate;

    price();
  }));
};
// レンタル金額表示
const price = () => {
  const rentalPeriod = document.getElementById("order_period");
  const itemPriceForm = document.getElementById("item_price");
  const itemPrice = itemPriceForm.getAttribute("data-item");
  const orderPrice = document.getElementById("order_price");
  const orderPriceInput = document.getElementById("order_price_input");
  const orderPiece = document.getElementById("order_piece");

  const totalPrice = rentalPeriod.value * itemPrice * orderPiece.value;
  orderPrice.innerHTML = totalPrice;
  orderPriceInput.value = totalPrice;
  

};

if (document.URL.match("/order/new")){
window.addEventListener('load', period)};

