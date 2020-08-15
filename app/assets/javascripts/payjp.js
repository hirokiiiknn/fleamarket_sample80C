// document.addEventListener(
//   "DOMContentLoaded", e => {
//     if ($("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
//       Payjp.setPublicKey('pk_test_3f9419193d0e8fa1db45f647'); //ここに公開鍵を直書き
//       let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得されます
//       btn.addEventListener("click", e => { //ボタンが押されたときに作動します
//         e.preventDefault(); //ボタンを一旦無効化します
//         let card = {
//           number: $("#card_number").val(),
//           exp_month: $("#exp_month").val(),
//           exp_year: $("#exp_year").val(),
//           cvc: $("#cvc").val()
//         }; //入力されたデータを取得します。
//         console.log(card);
//         debugger
//         Payjp.createToken(card, (status, response) => {
//           if (status === 200) { //成功した場合
//             $("#card_number").removeAttr("name");
//             $("#exp_month").removeAttr("name");
//             $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
//             $("#cvc").removeAttr("name");
//             $("#card_token").append(
//               $('<input type="hidden" name="payjp-token">').val(response.id)
//             ); //取得したトークンを送信できる状態にします
//             debugger
//             document.inputForm.submit();
//             alert("登録が完了しました"); //確認用
//           } else {
//             alert("カード情報が正しくありません。"); //確認用
//           }
//         });
//       });
//     }
//   },
//   false
// );
// 〜〜〜〜〜〜〜〜〜〜〜馬場元々のコードここまで〜〜〜〜〜〜〜〜〜〜〜〜

document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) {
      // "token_submit"というidをもつhtmlがあるページか？つまりカード作成ページか
      Payjp.setPublicKey("pk_test_3f9419193d0e8fa1db45f647");
      let btn = document.getElementById("token_submit");  // 送信ボタンをbtnに格納
      btn.addEventListener("click", e => {  // 送信ボタンがクリックされたとき
        e.preventDefault(); // デフォルトのブラウザの動きをいったんとめる(createアクションへの遷移を)
        let card = {  // cardに入力された値をハッシュで格納
          number: $("#card_number").val(),
          exp_month: $("#exp_month").val(),
          exp_year: $("#exp_year").val(),
          cvc: $("#cvc").val()
        };
        Payjp.createToken(card, function (status, response) {
          // カード情報をpayjpに送りカードトークンを(response.id)を受け取る。
          if (status === 200) {  // 正常な値の場合 
            $("#card_number").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name");
            $("#cvc").removeAttr("name");
            // name属性を削除することにより、dataベースに送るのを防ぐ。
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
              // <input type="hidden" name="payjp-token" value= response.id>が#card_tokenに追加される。
            );
            document.inputForm.submit(); // inputFormのsubmitを発動。（上記で停止していた）
            alert("登録が完了しました");
          } else {
            alert("カード情報が正しくありません。");
          }
        });
      });
    }
  },
  false
);
