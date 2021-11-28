document.addEventListener("turbolinks:load", function() {

    var buttons_inc = document.getElementsByClassName('quantity-change-inc');
    var buttons_dec = document.getElementsByClassName('quantity-change-dec');
    var item_prices = document.getElementsByClassName('item-price');
    var first_total = document.getElementById('first-total');
    var hst = document.getElementById("HST")
    var pst = document.getElementById("PST")
    var gst = document.getElementById("GST")
    var final_total_element = document.getElementById("final-total")


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
            priceElement.innerText = (current_price - (parseInt(base_price) / 100)).toFixed(2)
        } else {
            priceElement.innerText = parseInt(base_price) / 100
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

        priceElement.innerText = (current_price + (parseInt(base_price) / 100.0)).toFixed(2)

        changeTotal()
    }

    function changeTotal() {
        var total = 0.0;
        var final_total = 0.0

        for (var i = 0; i < item_prices.length; i++) {

            (function(index) {

                total = (parseFloat(total) + parseFloat(item_prices[index].innerText)).toFixed(2)
            })(i);
        }

        final_total += calculateGST(total)
        final_total += calculatePST(total)
        final_total += calculateHST(total)
        calculateFinalTotal(final_total, total)
        first_total.innerText = total
    }

    function calculateHST(total) {
        calculated_hst = 0.0;

        if (hst != null) {
            var base_hst = document.getElementById("hst_hidden").value
            calculated_hst = total * parseFloat(base_hst)
            hst.innerText = calculated_hst.toFixed(2)

        }

        return parseFloat(calculated_hst.toFixed(2))
    }

    function calculatePST(total) {
        calculated_pst = 0.0;

        if (pst != null) {
            var base_pst = document.getElementById("pst_hidden").value
            calculated_pst = total * parseFloat(base_pst)
            pst.innerText = calculated_pst.toFixed(2)

        }
        return parseFloat(calculated_pst.toFixed(2))
    }

    function calculateGST(total) {
        calculated_gst = 0.0;

        if (gst != null) {
            var base_gst = document.getElementById("gst_hidden").value
            calculated_gst = total * parseFloat(base_gst)
            gst.innerText = calculated_gst.toFixed(2)

        }
        return parseFloat(calculated_gst)
    }

    function calculateFinalTotal(final_total, total) {

        if (final_total_element != null) {
            new_total = parseFloat(final_total) + parseFloat(total)

            final_total_element.innerText = new_total.toFixed(2)
        }
    }
});