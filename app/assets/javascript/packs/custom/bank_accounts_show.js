document.addEventListener("DOMContentLoaded",function(){
  Show.init()
})

const Show = (() => {
  let btnNewTransaction,
      modalTransaction,
      btnSave,
      inputAmount,
      selectTransactionType,
      parameters,
      bankAccountId,
      notification;

  const url = "/api/v1/bank_accounts/new_transaction";
  const fetchElements = () => {
    btnNewTransaction = document.querySelector("#btn-new-transaction");
    modalTransaction = document.querySelector("#modal-transaction");
    btnSave = document.querySelector("#btn-transaction-save");
    inputAmount = document.querySelector("#input-amount");
    selectTransactionType = document.querySelector("#select-transaction-type");
    parameters = document.querySelector("#parameters");
    notification = document.querySelector(".notification");
    bankAccountId = parameters.dataset.bankAccountId;
  };

  const disableControls = () => {
    btnSave.disabled = true;
    inputAmount.disabled = true;
    selectTransactionType.disabled = true;
  };

  const enableControls = () => {
    btnSave.disabled = false;
    inputAmount.disabled = false;
    selectTransactionType.disabled = false;
  };

  const initializeEvents = () => {
    btnNewTransaction.addEventListener("click", () => {
      $("#modal-transaction").on("shown.bs.modal").modal('show');
      $('#modal-transaction').appendTo("body").modal('show');
    });
    
    btnSave.addEventListener("click", () => {
      const amount = inputAmount.value;
      const transactionType = selectTransactionType.value;
      disableControls();

      console.log(transactionType);

      notification.innerHTML = ("");
      $.ajax({
        url: url,
        method: 'POST',
        dataType: 'json',
        data: {
          amount: amount,
          transactionType: transactionType,
          bankAccountId: bankAccountId
        }, success: function(response) {
          window.location.href = "/bank_accounts/" + bankAccountId;
        },
        error: function(response) {
          notification.innerHTML = (JSON.parse(response.responseText).errors.join());
          enableControls();
        }
      })



    })
  }

  const init = () => {
    fetchElements();
    initializeEvents();
  }
  return {
    init: init
  }
 })();  