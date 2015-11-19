# Introduction #
ADK 구성에 있어 [Arduino](Arduino.md) 보드와 [Android](Android.md)를 연결해 주는 쉴드가 꼭 필요하다.
이 구성을 위한 소스코드가 필요.

# Details #
RT-ADK가 아니기 때문에 http://Circuitsathome.com 에서 구매한 USB Host Shield(MAX3421E 칩셋 기반)의 아두이노 호환 코드를 받아서 설치
```
/usr/share/arduino/libraries/FELIS_USB_HOST_SHIELD
```
해야 한다.

다운로드 주소는 다음과 같음.
https://github.com/felis/USB_Host_Shield_2.0

기존 1.0 버전 코드와 달라진 점과 코딩시 주의사항 확인바람.
[2.0 라이브러리 변경사항](https://www.circuitsathome.com/mcu/google-open-accessory-interface-for-usb-host-shield-library-2-0-released)