### Donation

Ми використовуємо платіжну кнопку [WayForPay](https://wayforpay.com/uk) на сторінці https://pivorak.com/donate.

Техпідтримка працює добре через Telegram, рекомендую.

### Корисні посилання

- [Налаштування магазину тут](https://m.wayforpay.com/uk/mportal/payed-block-configure/notice-update?id=50029)

### Webhoook / Slack повідомлення

Після оплати ми приймаємо webhook і постимо Slack повідомлення.

#### Як працюють перенаправлення після оплати?

у [Налаштуваннях магазину](https://m.wayforpay.com/uk/mportal/payed-block-configure/notice-update?id=50029) будуть здійснені перенаправлення на вказані URL-и: approvedUrl, declinedUrl, returnUrl.

### Відомі проблеми

- Apple Pay забороняє показ кнопки оплати в iframe (віджеті), можливий тільки перехід за прямим посиланням.

### Ідеї:
- зробити повідомлення неанонімними
- додати можливість вказати повідомлення яке буде опубліковане в Slack
