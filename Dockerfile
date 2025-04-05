# Use a Node.js base image
FROM node:16

# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the React app (fix the typo here)
RUN --mount=type=cache,id=s/80ca1c18-e775-4ed7-aa39-1885f840a342-node_modules/cache,target=/app/node_modules/.cache npm run build

# Expose port 3000 for React
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]
