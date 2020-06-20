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

  const account_numbers = {
    "1010": "Narodowy Bank Polski",
    "1020": "PKO BP",
    "1030": "City Handlowy",
    "1050": "ING Bank Śląski",
    "1130": "BGK",
    "1140": "mBank",
    "1160": "Bank Millenium",
    "1240":	"Pekao SA",
    "1280":	"HSBC",
    "1320":	"Bank Pocztowy",
    "1540":	"BOŚ Bank",
    "1580":	"Mercedes-Benz Bank",
    "1610":	"SGB - Bank",
    "1670":	"RBS Bank",
    "1680":	"Plus Bank",
    "1840":	"Societe Generale",
    "1870":	"Nest Bank",
    "1930":	"Bank Polskiej Spółdzielczości",
    "1940":	"Credit Agricole",
    "1950":	"Idea Bank",
    "2020": "WSB Bank",
    "2030":	"BNP Paribas",
    "2070":	"FCE Bank Polska",
    "2120":	"Santander Consumer Bank",
    "2130":	"Volkswagen Bank",
    "2140":	"Fiat Bank Polska",
    "2160":	"Toyota Bank",
    "2190":	"DnB Nord",
    "2480":	"Getin Noble Bank",
    "2490":	"T-Mobile Usługi Bankowe",
  };

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

    selectTransactionType.addEventListener('change', (event) => {
      let bank_name_text = document.querySelector('.name_bank');
      if (event.target.value == 'przelew') {
        document.querySelector('.transfer').classList.remove('d-none');
        const input_account_number = document.querySelector('#transfer_account_number');
        input_account_number.addEventListener('input', (e) => {
          let input_value = e.target.value;
          if (input_value.length == 32 ) {
            input_value = input_value.slice(3, 7);
            if(account_numbers[input_value] != undefined) {
              bank_name_text.innerHTML = account_numbers[input_value];
            } else {
              bank_name_text.innerHTML = "";
            };
          };
        })
      }
      else {
        document.querySelector('.transfer').classList.add('d-none');
        document.querySelector('#transfer_account_number').value = "";
        bank_name_text.innerHTML = "";
      }
    });
    
    btnSave.addEventListener("click", () => {
      const amount = inputAmount.value;
      const transactionType = selectTransactionType.value;
      const accountNumberTransfer = document.querySelector('#transfer_account_number').value;
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
          bankAccountId: bankAccountId,
          accountNumberTransfer: accountNumberTransfer
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