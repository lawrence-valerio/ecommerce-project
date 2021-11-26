document.addEventListener("turbolinks:load", function() {

    var buttons_inc = document.getElementsByClassName('quantity-change-inc');
    var buttons_dec = document.getElementsByClassName('quantity-change-dec');
    var item_prices = document.getElementsByClassName('item-price');
    var first_total = document.getElementById('first-total');

    for (var i = 0; i < buttons_inc.length; i++) {

        (function(index) {
            buttons_inc[index].addEventListener("click", function() {
                increasePrice(this);
            })
        })(i);
    }

    for (var i = 0; i < buttons_dec.length; i++) {

        (function(index) {
            buttons_dec[index].addEventListener("click", function() {
                decreasePrice(this);

            })
        })(i);
    }


    function decreasePrice(element) {
        card_id = element.parentElement.parentElement.parentElement.childNodes[3].value
        base_price = element.parentElement.parentElement.parentElement.childNodes[5].value
        priceElement = element.parentElement.parentElement.parentElement.parentElement.childNodes[3].childNodes[1].childNodes[0].childNodes[1]
        quantity = parseInt(element.parentElement.childNodes[3].value);

        current_price = parseFloat(priceElement.innerText)
        if (quantity != 1) {
            priceElement.innerText = (current_price - parseFloat(base_price)).toFixed(2)
        } else {
            priceElement.innerText = parseFloat(base_price)
        }

        changeTotal()
    }

    function increasePrice(element) {
        card_id = element.parentElement.parentElement.parentElement.childNodes[3].value
        base_price = element.parentElement.parentElement.parentElement.childNodes[5].value
        priceElement = element.parentElement.parentElement.parentElement.parentElement.childNodes[3].childNodes[1].childNodes[0].childNodes[1]
        decrease_btn_element = element.parentElement.childNodes[1]
        quantity = parseInt(element.parentElement.childNodes[3].value);

        current_price = parseFloat(priceElement.innerText)

        priceElement.innerText = (current_price + parseFloat(base_price)).toFixed(2)

        changeTotal()
    }

    function changeTotal() {
        var total = 0.0;

        for (var i = 0; i < item_prices.length; i++) {

            (function(index) {

                total = parseFloat(total) + parseFloat(item_prices[index].innerText)
            })(i);
        }

        first_total.innerText = total.toFixed(2)
    }
});