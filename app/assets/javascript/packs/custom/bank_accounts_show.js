document.addEventListener("DOMContentLoaded",function(){
  Show.init()
})

const Show = (() => {
  let btnNewTransaction,
      modalTransaction,
      btnSave,
      inputAmount,
      selectTransactionType;

  const fetchElements = () => {
    btnNewTransaction = document.querySelector("#btn-new-transaction");
    modalTransaction = document.querySelector("#modal-transaction");
    btnSave = document.querySelector("#btn-transaction-save");
    inputAmount = document.querySelector("#input-amount");
    selectTransactionType = document.querySelector("#select-transaction-type");
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
    });
    
    btnSave.addEventListener("click", () => {
      disableControls();
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