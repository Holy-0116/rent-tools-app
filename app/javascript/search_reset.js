function reset(){
  // クリアボタンが押されたらイベント発火
  const resetBtn = document.getElementById("reset");
  resetBtn.addEventListener('click',() =>{
    // 並べ替えボタンのChangeイベントを止める
    const search = document.getElementById("item_search");
      search.addEventListener('submit',(e)=>{
        e.preventDefault();
      })
      debugger
    // 並べ替え選択ボタンの0を選択させる
    const orderBtn = document.getElementById("q_sorts"); 
    orderBtn.selectedIndex = 0;
    // キーワードフォームのValueを""にする
    const keyword = document.getElementById("q_name_or_explanation_cont").value ="";
    // カテゴリー選択ボタンの0を選択させる
    const category = document.getElementById("q_category_id_eq");
    category.selectedIndex = 0;
    // 検索金額入力のValueを""にする
    const priceMin = document.getElementById("q_price_gteq").value ="";
    const priceMax = document.getElementById("q_price_lteq").value ="";

    // デフォルトイベント発火
    const searchForm = document.getElementById("item_search").submit();
  }) 
}


if (document.URL.match("/search")){
  window.addEventListener('load', reset)};