function price() {
  const itemPrice = document.getElementById("item-price");
  const taxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById('profit');
  itemPrice.onkeyup = function() {
  // itemPrice.addEventListener('click', () => {
    const itemPriceValue = document.getElementById("item-price").value;
    // value = itemPrice.innerHTML
    value = itemPriceValue
    taxPrice.innerHTML = Math.floor(value * 0.1);
    profit.innerHTML = Math.floor(value * 0.9);
    // console.log(itemPriceValue)
    // taxPrice.innerHTML = value * 1.1
  // });
  };
}
window.addEventListener('load', price);