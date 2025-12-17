FROM node:20-slim

WORKDIR /usr/src/app

# Install build tools for native modules, then remove them after install to keep image small
COPY package*.json ./
RUN apt-get update \
	&& apt-get install -y --no-install-recommends build-essential python3 make g++ ca-certificates \
	&& npm install --production \
	&& apt-get remove -y build-essential python3 make g++ \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

# Copy app source
COPY . .

# Ensure data directory exists and is writable
RUN mkdir -p /usr/src/app/data

VOLUME ["/usr/src/app/data"]

EXPOSE 3000

CMD ["npm", "start"]
