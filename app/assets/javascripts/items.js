
$(function () {
  const buildFileField = (index) => {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[images_attributes][${index}][image]"
                    id="item_images_attributes_${index}_image"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url) => {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px", class="image-index">`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  $(".pic-up").on('click', function () {
    const file_field = $(".js-file:last"); // 一番最後のfile_field（新規でアップロードする箇所）を取得
    file_field.trigger("click"); // file_fieldをクリックさせる。
  })

  $('.js').on('change', '.js-file', function (e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('image', blobUrl);
    } else {  // 新規画像追加の処理

      if ($(".image-index").length < 10) {
        $('#previews').append(buildImg(targetIndex, blobUrl));
        // fileIndexの先頭の数字を使ってinputを作る
        $('.js-file_group').append(buildFileField(fileIndex[0]));
      } else {
        alert("投稿できる画像は10枚までです。消したい画像をクリックしてください。");
      }

      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
  });

  $('.js').on('click', 'img', function () {
    const targetIndex = $(this).data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    // 画像入力欄が0個にならないようにしておく
    // if ($('.image-index').length == 0) $('.js').append(buildFileField(fileIndex[0]));
    // $(`img[data-index="${targetIndex}"]`).parent().remove();
  });
});