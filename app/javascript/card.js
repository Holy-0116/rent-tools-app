const card = () =>{
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById("customer_form");
  // formがなければイベント発火しないようにする記述
  if (form){
  form.addEventListener("submit",function(e){
    e.preventDefault();
    const formResult = document.getElementById("customer_form");
    const formData = new FormData(formResult);
    
    const Card = {
      number: formData.get("number"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
      cvc: formData.get("cvc")
    };
    Payjp.createToken(Card,function(status, response){
      if (status === 200) {
        const token = response.id;
        const renderDom = document.getElementById("customer_form");
        const tokenObj = `<input value= ${token} type="hidden" name= "card_token">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      } 
      
      document.getElementById("number").removeAttribute("name");
      document.getElementById("exp_month").removeAttribute("name");
      document.getElementById("exp_year").removeAttribute("name");
      document.getElementById("cvc").removeAttribute("name");

      document.getElementById("customer_form").submit();
      document.getElementById("customer_form").reset();
    })
  })};
};
// クレジットカード入力ページなら実行
if (document.URL.match("/card") || document.URL.match("/new_card")) {
window.addEventListener('load', card)};