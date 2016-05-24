FROM alexellis2/scroll-phat
RUN pip install flask

ADD lights.py ./
ADD app.py ./

EXPOSE 5000

CMD ["python2", "app.py"]
