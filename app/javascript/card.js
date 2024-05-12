const pay = () => {
    // gon Gemで渡されたPAY.JPテスト公開鍵の環境変数（gon.public_key）を変数publicKeyに代入
  const publicKey = gon.public_key
    // PAY.JPテスト公開鍵を変数payjpに代入
  const payjp = Payjp(publicKey)
    // elementsインスタンスを作成
  const elements = payjp.elements();
    // カード番号入力欄のフォームのelementインスタンスを作成
  const numberElement = elements.create('cardNumber');
    // 有効期限入力欄のフォームのelementインスタンスを作成
  const expiryElement = elements.create('cardExpiry');
    // CVC入力欄のフォームのelementインスタンスを作成
  const cvcElement = elements.create('cardCvc');

    // #number-formというid属性の要素とフォームを置き換える
  numberElement.mount('#number-form');
    // #expiry-formというid属性の要素とフォームを置き換える
  expiryElement.mount('#expiry-form');
    // #cvc-formというid属性の要素とフォームを置き換える
  cvcElement.mount('#cvc-form');

    // フォームに設定している”charge-form”というidを指定して要素を取得し、変数formに代入
  const form = document.getElementById('charge-form')
    // 送信ボタンをクリックしたら、tokenを生成してサーバーサイドへ送信
  form.addEventListener("submit", (e) => {
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
        // フォームにあるクレジットカード情報（カード番号、有効期限、CVC）は削除
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
        // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
    });
      // イベント処理において、デフォルトのイベント動作をキャンセル
    e.preventDefault();
  });
};

  // ページをロードした時に実行
window.addEventListener("turbo:load", pay);
  // renderが実行された時も実行
window.addEventListener("turbo:render", pay);