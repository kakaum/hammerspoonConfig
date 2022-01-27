-- When KakaoTalk gets focused, change input source to Korean. When unfocused, to ABC.
hs.window.filter.new(false):setAppFilter('KakaoTalk')
:subscribe(hs.window.filter.windowFocused, toKorean)
:subscribe(hs.window.filter.windowUnfocused, toABC)
