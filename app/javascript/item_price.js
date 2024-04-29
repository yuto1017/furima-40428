window.addEventListener('turbo:load', () => {
    // 入力した数値（金額）をpriceInputという変数に格納する
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {

    // priceInputに格納した数値をinputValueという変数に格納する
  const inputValue = priceInput.value;

    // 販売手数料を表示する場所のidから取得した要素をaddTaxDomという変数に格納する
  const addTaxDom = document.getElementById("add-tax-price");

    // 販売利益を表示する場所のidから取得した要素をprofitDomという変数に格納する
  const profitDom = document.getElementById("profit");

    // 入力した数値（金額）から販売手数料を算出する（小数点以下を切り捨て）
  addTaxDom.innerHTML = Math.floor(inputValue * 0.1);

    // 入力した数値（金額）から販売手数料を差し引いて販売利益を算出する
  profitDom.innerHTML = inputValue - addTaxDom.innerHTML;
  })
});