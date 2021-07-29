#!/bin/bash

curl "https://api.telegram.org/bot${TELEGRAM_PIRATE_BOT_TOKEN}/sendMessage?chat_id=${TELEGRAM_CHAT_ID}&text=%F0%9F%94%BB $TR_TORRENT_NAME ha terminado de descargarse"
