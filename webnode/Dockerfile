FROM alexellis2/node4.x-arm:v6

ADD package.json ./
RUN npm i

ADD index.js ./

EXPOSE 3000
CMD ["node", "index.js"]
