This Dockerfile builds a GPIO web server

* It listens for web connections on port 5000
* For every request it will flash a number of LEDs
* It was designed to work with the Ciseco PiLite

Please fork the example and try it for yourself. You will need to change the following line in `lights.py`

```
GPIO.setmode(GPIO.BOARD)
```

to:

```
GPIO.setmode(GPIO.BCM)
```

Then you can edit the list of LED pins or even connect a buzzer to your Pi.



