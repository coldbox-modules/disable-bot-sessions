# disable-bot-sessions

[![Master Branch Build Status](https://img.shields.io/travis/coldbox-modules/disable-bot-sessions/master.svg?style=flat-square&label=master)](https://travis-ci.org/coldbox-modules/disable-bot-sessions)

## Automatically disable sessions for likely bots

This module registers a [`preProcess`](https://coldbox.ortusbooks.com/content/full/interceptors/application_life_cycle.html)
[interceptor](https://coldbox.ortusbooks.com/content/full/interceptors/) that detects
likely bots and sets their session timeout to `1`.
