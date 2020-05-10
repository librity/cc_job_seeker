document.addEventListener("turbolinks:load", function () {
  $(document).ready(function () {
    $(".cpf_input").mask("000.000.000-00");
    $(".cnpj_input").mask("00.000.000/0000-00");

    $(".user_form").submit(function () {
      const value = $(".cpf_input").cleanVal();
      $(".cpf_input").val(value);
    });

    $(".subsidiary_form").submit(function () {
      const value = $(".cnpj_input").cleanVal();
      $(".cnpj_input").val(value);
    });
  });
});
