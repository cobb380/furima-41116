function initializePrice() {
  const priceInput = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  if (priceInput && addTaxPrice && profit) {
    const price = parseInt(priceInput.value, 10);

    if (!isNaN(price)) {
      const tax = Math.floor(price * 0.1); // 販売手数料 (10%)
      const profitValue = price - tax; // 販売利益

      addTaxPrice.textContent = tax.toLocaleString(); // 販売手数料を表示
      profit.textContent = profitValue.toLocaleString(); // 販売利益を表示
    } else {
      addTaxPrice.textContent = '0';
      profit.textContent = '0';
    }
  }
}

function price() {
  initializePrice(); // 初期化用関数を呼び出し

  const priceInput = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  if (priceInput) {
    priceInput.addEventListener('input', function() {
      const price = parseInt(priceInput.value, 10);

      if (!isNaN(price)) {
        const tax = Math.floor(price * 0.1); // 販売手数料 (10%)
        const profitValue = price - tax; // 販売利益

        addTaxPrice.textContent = tax.toLocaleString(); // 販売手数料を表示
        profit.textContent = profitValue.toLocaleString(); // 販売利益を表示
      } else {
        addTaxPrice.textContent = '0';
        profit.textContent = '0';
      }
    });
  }
}

window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);
