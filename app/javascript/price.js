if(document.URL.match(/new/)) {
  function price() {
    const itemPrice = document.getElementById("item-price");
    const taxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById('profit');
    itemPrice.addEventListener('input', () => {
      const itemPriceValue = document.getElementById("item-price").value;
      value = itemPriceValue
      taxPrice.innerHTML = Math.floor(value * 0.1);
      profit.innerHTML = Math.floor(value * 0.9);
    });
  }
window.addEventListener('load', price);
}