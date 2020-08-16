$(function () {
  Payjp.setPublicKey("pk_test_3f9419193d0e8fa1db45f647");
  $("#token_submit").click(function (e) {
    e.preventDefault();
    let card = {
      number: $("#card_number")[0].value,
      cvc: $("#cvc")[0].value,
      exp_month: $("#exp_month")[0].value,
      exp_year: $("#exp_year")[0].value
    };
    debugger
    Payjp.createToken(card, function (status, response) {
      if (status === 200) {
        $("#card_token").append(
          $('<input type="hidden" name="payjp-token">').val(response.id)
        );
        $('#charge-form').submit();
      } else {
        alert("カード情報が正しくありません。");
      }
    });
  });
});
