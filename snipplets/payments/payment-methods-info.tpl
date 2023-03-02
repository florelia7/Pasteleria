{% macro paymentMethodsInfo(paymentProvider, product) %}
    {% for paymentMethod in paymentProvider.supported_payment_methods %}
        {% set hasDiscount = paymentMethod.discount > 0 %}

        {# Payment Method Title #}
        <div class="box-title">{{ paymentMethod.name }}</div>

        <div id="info-payment-method-{{ paymentMethod.id }}" class="box-container">
            {# Payment Method Discount #}
            {% if hasDiscount %}
                <div class="m-top-half m-bottom">
                    <span><strong>{{ paymentMethod.discount }}% {{'de descuento' | translate }}</strong> {{'pagando con' | translate }} {{ paymentMethod.name }}</span>
                </div>
            {% endif %}

            {# Payment Method Logos #}
            <div>
                {% for logo in paymentMethod.logos %}
                    <span class="installments-card">
                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ logo | payment_new_logo }}" class="lazyload card-img card-img-medium" alt="">
                    </span>
                {% endfor %}
            </div>

            {# Payment Method Total #}
            <h5 class="m-top-quarter">
                <span class="m-right-quarter">{{ 'Total:' | translate }}</span>
                {% if hasDiscount %}
                    {% set priceWithDiscount = product.price - ((product.price * paymentMethod.discount) / 100) %}
                    <span class="price-compare m-right-half">{{ product.price | money }}</span>
                    <strong class="js-installments-one-payment h3 weight-strong text-primary">{{ priceWithDiscount | money }}</strong>
                {% else %}
                    <strong class="js-installments-one-payment">{{ product.price | money }}</strong>
                {% endif %}
            </h5>
            {% if hasDiscount %}
                <div class="font-small m-top-quarter">{{'El descuento será aplicado sobre el costo total de la compra (sin envío) al finalizar la misma.' | translate }}</div>
            {% endif %}
        </div>
    {% endfor %}
{% endmacro %}