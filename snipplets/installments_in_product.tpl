{% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 %}
{% if product_can_show_installments %}
    <div class="js-max-installments-container installments m-bottom-quarter">
        {% set max_installments_without_interests = product.get_max_installments(false) %}
        {% set has_no_interest_payments = max_installments_without_interests and max_installments_without_interests.installment > 1 %}

        {% if has_no_interest_payments %}
            {% set card_icon_color = 'svg-accent-fill' %}
        {% else %}
            {% set card_icon_color = 'svg-text-fill' %}
        {% endif %}

        {% include "snipplets/svg/credit-card.tpl" with {fa_custom_class: "payment-credit-card m-right-quarter " ~ card_icon_color} %}
        
        {% if max_installments_without_interests and max_installments_without_interests.installment > 1 %}
                <div class="js-max-installments installments d-inline-block {% if settings.accent_color_active %}text-accent{% endif %}">{{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas sin interés de <strong class='js-installment-price installment-price'>{2}</strong>" | t(max_installments_without_interests.installment, max_installments_without_interests.installment_data.installment_value_cents | money) }}</div>
        {% else %}
            {% set max_installments_with_interests = product.get_max_installments %}
            {% if max_installments_with_interests %}
                <div class="js-max-installments installments d-inline-block">{{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas de <strong class='js-installment-price installment-price'>{2}</strong>" | t(max_installments_with_interests.installment, max_installments_with_interests.installment_data.installment_value_cents | money) }}</div>
            {% else %}
                <div class="js-max-installments installments d-inline-block" style="display: none;">
                {% if product.max_installments_without_interests %}
                    {{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas sin interés de <strong class='js-installment-price installment-price'>{2}</strong>" | t(null, null) }}
                {% else %}
                    {{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas de <strong class='js-installment-price installment-price'>{2}</strong>" | t(null, null) }}
                {% endif %}
                </div>
            {% endif %}
        {% endif %}
    </div>
{% endif %}
